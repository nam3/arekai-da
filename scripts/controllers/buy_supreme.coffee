{Account} = require 'arekai-da-plugins'
IncomingWebhook = require '../services/slack/incoming_webhook'
Supreme = require('arekai-da-plugins').Supreme.MachineGun
createTaskCluster = require '../services/create_task_cluster'
utils = require '../utils/hubot'

module.exports = class BuySupreme

  constructor: ({
    @slackName
    @imgAlt
    @dryrunFlag
    @room
    @from
    @interval
    @times
    @concurrency
  }) ->
    @slack = new IncomingWebhook
      incomingWebhookUrl: process.env.HUBOT_SLACK_INCOMINGWEBHOOK
      title: "<@#{@slackName}>: Buying Supreme Item #{@imgAlt}, using machine-gun :gun:"
      channel: @room
    @account = new Account
      db: 'arekai-da'
      clientId: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
      clientSecret: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
      redirectUrn: process.env.HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
      refreshToken: process.env.HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN

  execute: =>

    @account.getAccount @slackName, 'supreme'
      .then (user) =>
        if @from
          utils.isValidDatetime(@from)
        else
          @from = utils.nowPlus8Seconds()
        taskName = @slack.title
        factory = =>
          supreme = new Supreme user, @imgAlt, undefined, @dryrunFlag
          return => supreme.execute()

        params =
          from: @from
          interval: @interval
          times: @times
          concurrency: @concurrency
        createTaskCluster taskName, factory, @slack, params

      .catch (err) =>
        errMessage = if err.hasOwnProperty('stack') then err.stack else err
        @slack.send errMessage
