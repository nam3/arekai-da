{Account} = require 'arekai-da-plugins'
IncomingWebhook = require '../services/slack/incoming_webhook'
Sea = require('arekai-da-plugins').Sea
createTaskCluster = require '../services/create_task_cluster'
utils = require '../utils/hubot'

module.exports = class BuySeaBag

  constructor: ({
    @slackName
    @dryrunFlag
    @room
    @from
    @interval
    @times
    @concurrency
  }) ->
    @slack = new IncomingWebhook
      incomingWebhookUrl: process.env.HUBOT_SLACK_INCOMINGWEBHOOK
      title: "#{@slackName}: Buying Sea Bag #{@url}"
      channel: @room
    @account = new Account
      db: 'arekai-da'
      clientId: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
      clientSecret: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
      redirectUrn: process.env.HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
      refreshToken: process.env.HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN

  execute: =>

    @account.getAccount @slackName, 'sea'
      .then (user) =>
        if @from
          utils.isValidDatetime(@from)
        else
          @from = utils.nowPlus8Seconds()
        taskName = "<@#{@slackName}>: Buying Sea Bag #{@url}"
        factory = =>
          sea = new Sea user.email, user.password
          return => sea.execute(@dryrunFlag)

        params =
          from: @from
          interval: @interval
          times: @times
          concurrency: @concurrency
        createTaskCluster taskName, factory, @slack, params

      .catch (err) =>
        message = if err.hasOwnProperty('stack') then err.stack else err
        @slack.send message
