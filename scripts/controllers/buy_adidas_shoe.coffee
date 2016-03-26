{Account} = require 'arekai-da-plugins'
IncomingWebhook = require '../services/slack/incoming_webhook'
Adidas = require('arekai-da-plugins').Adidas.Shoe
createTaskCluster = require '../services/create_task_cluster'
utils = require '../utils/hubot'

module.exports = class BuyAdidasShoe

  constructor: ({
    @slackName
    @url
    @size
    @dryrunFlag
    @room
    @from
    @interval
    @times
    @concurrency
  }) ->
    @slack = new IncomingWebhook
      incomingWebhookUrl: process.env.HUBOT_SLACK_INCOMINGWEBHOOK
      title: "#{@slackName}: Buying Adidas Shoe #{@url}"
      channel: @room
    @account = new Account
      db: 'arekai-da'
      clientId: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
      clientSecret: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
      redirectUrn: process.env.HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
      refreshToken: process.env.HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN

  execute: =>

    @account.getAccount @slackName, 'adidas'
      .then (user) =>
        if @from
          utils.isValidDatetime(@from)
        else
          @from = utils.nowPlus8Seconds()
        taskName = "<@#{@slackName}>: Buying Adidas Shoe #{@url}"
        factory = =>
          adidas = new Adidas user.name, user.password, @url, @size
          adidas.login().then ->
          return => adidas.execute(@dryrunFlag)

        params =
          from: @from
          interval: @interval
          times: @times
          concurrency: @concurrency
        createTaskCluster taskName, factory, @slack, params

      .catch (err) =>
        message = if err.hasOwnProperty('stack') then err.stack else err
        @slack.send message
