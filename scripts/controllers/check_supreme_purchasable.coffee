IncomingWebhook = require '../services/slack/incoming_webhook'
Supreme = require('arekai-da-plugins').Supreme.PurchasableChecker
createTaskCluster = require '../services/create_task_cluster'
utils = require '../utils/hubot'

module.exports = class CheckSupuremePurchasable

  constructor: ({
    @slackName
    @proxyServerString
    @imgAlt
    @room
    @from
    @interval
    @times
    @concurrency
  }) ->
    @slack = new IncomingWebhook
      incomingWebhookUrl: process.env.HUBOT_SLACK_INCOMINGWEBHOOK
      title: "<@#{@slackName}>: Checking Supreme Item Purchasable #{@imgAlt}"
      channel: @room

  execute: =>

    if @from
      utils.isValidDatetime(@from)
    else
      @from = utils.nowPlus8Seconds()
    taskName = @slack.title
    factory = =>
      supreme = new Supreme @proxyServerString, @imgAlt
      return -> supreme.execute()

    params =
      from: @from
      interval: @interval
      times: @times
      concurrency: @concurrency
    createTaskCluster taskName, factory, @slack, params
