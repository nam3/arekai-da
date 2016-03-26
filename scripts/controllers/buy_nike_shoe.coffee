{Account} = require 'arekai-da-plugins'
IncomingWebhook = require '../services/slack/incoming_webhook'
Nike = require('arekai-da-plugins').Nike.Shoe
createTaskCluster = require '../services/create_task_cluster'
utils = require '../utils/hubot'

module.exports = class BuyNikeShoe

  constructor: ({
    @slackName
    @url
    @size
    @dryrunFlag
    @purchaseFlag
    @room
    @from
    @interval
    @times
    @concurrency
  }) ->
    @slack = new IncomingWebhook
      incomingWebhookUrl: process.env.HUBOT_SLACK_INCOMINGWEBHOOK
      title: "#{@slackName}: Buying Nike Shoe #{@url}"
      channel: @room
    @account = new Account
      db: 'arekai-da'
      clientId: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
      clientSecret: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
      redirectUrn: process.env.HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
      refreshToken: process.env.HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN

  execute: =>

    @account.getAccount @slackName, 'nike'
      .then (user) =>
        if @from
          utils.isValidDatetime(@from)
        else
          @from = utils.nowPlus8Seconds()
        taskName = "<@#{@slackName}>: Buying Nike Shoe #{@url}"
        factory = =>
          nike = new Nike user.name, user.password, @url, @size
          return => nike.execute(@dryrunFlag, @purchaseFlag)

        params =
          from: @from
          interval: @interval
          times: @times
          concurrency: @concurrency
        createTaskCluster taskName, factory, @slack, params

      .catch (err) =>
        message = if err.hasOwnProperty('stack') then err.stack else err
        @slack.send message
