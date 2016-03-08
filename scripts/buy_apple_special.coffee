# Description
#   Purchase Apple Special Deal
#
# Configuration:
#   HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
#   HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
#   HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
#   HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN
#   HUBOT_SLACK_INCOMINGWEBHOOK
#
# Commands:
#   arekai-da: buy apple special "TARGET_URL" --time=crontime
#
# Author:
#   JumpeiArashi

{Account} = require 'arekai-da-plugins'
AppleSpecialDeal = require('arekai-da-plugins').Apple.SpecialDeal
HexColor = require './models/hex_color'
Slack = require './services/slack/incoming_webhook'
{Task} = require './services/task'

module.exports = (robot) ->

  robot.respond /buy\s+apple\s+special\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--time=(.+)|)$/, (res) ->

    url = res.match[1]
    crontime = res.match[2]

    slack = new Slack
      incomingWebhookUrl: process.env.HUBOT_SLACK_INCOMINGWEBHOOK
      title: "Apple special deal: #{url}"
      color: HexColor.lightgreen

    account = new Account
      db: 'arekai-da'
      clientId: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
      clientSecret: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
      redirectUrn: process.env.HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
      refreshToken: process.env.HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN

    account.getAccount res.message.user.name, 'apple'
      .then (user) ->
        apple = new AppleSpecialDeal user.name, user.password, user.securitycode, url

        fn = ->

          apple.execute()
            .then (purchaseProducts) ->
              if purchaseProducts
                slack.notify
                  text: """
                    <@#{res.message.user.name}>
                    Purchased #{purchaseProducts}
                  """
                return true

              else
                return false

            .catch (err) ->
              slack.notify
                text: "#{err.message}"
                color: HexColor.tomato
              return false

        task = new Task slack.title, fn, crontime
        res.send "Sir, yes, sir! Purchase apple item. #{url}"
