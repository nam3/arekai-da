{Account} = require 'arekai-da-plugins'
CreditCard = require('arekai-da-plugins').CreditCard.Supreme
IncomingWebhook = require '../services/slack/incoming_webhook'
Supreme = require('arekai-da-plugins').Supreme.New
{Task} = require '../services/task'
TaskCluster = require '../services/task_cluster'
utils = require '../utils/supreme'

module.exports = class BuySupremeNew

  constructor: ({
    @slackName
    @creditCardFlag
    @imgAlt
    @size
    @cronTime
    @dryrunFlag
    @room
  }) ->
    @slack = new IncomingWebhook
      incomingWebhookUrl: process.env.HUBOT_SLACK_INCOMINGWEBHOOK
      title: "#{@slackName}: Buying Supreme New Item #{@imgAlt}"
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
        size = utils.convertToSupremeSize(@size) if @size
        creditCard = if @creditCardFlag then new CreditCard user.creditCardCompany, user.creditCardNumber, user.creditCardMonth, user.creditCardYear, user.securitycode else undefined
        supreme = new Supreme user.firstname, user.lastname, user.email, user.phonenumber, user.zipcode, user.state, user.city, user.address, @imgAlt, creditCard, size
        taskName = "<@#{@slackName}>: Buying Supreme New Item #{@imgAlt}"
        fn = =>
          supreme.execute(@dryrunFlag)

        task = new Task taskName, fn, @cronTime
        taskCluster = new TaskCluster(@slack, [task])
        task.attach [taskCluster]

      .catch (err) =>
        errMessage = if err.hasOwnProperty('stack') then err.stack else err
        @slack.send errMessage
