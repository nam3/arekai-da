# Description
#   Purchase Supreme New Item
#
# Configuration:
#   HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
#   HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
#   HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
#   HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN
#
# Commands:
#   arekai-da: buy supreme new "IMAGE_ALT_ATTRIBUTE" --size=s|m|l|xl --credit-card=true --time=CRONTIME
#
# Author:
#   JumpeiArashi

{Account} = require 'arekai-da-plugins'
SupremeCreditCard = require('arekai-da-plugins').CreditCard.Supreme
SupremeNew = require('arekai-da-plugins').Supreme.New
SupremeUtils = require './utils/supreme'
utils = require './utils/crontime'
{Task} = require './services/task'

module.exports = (robot) ->

  robot.respond /buy\s+supreme\s+new\s+([\w_-]+)(?:\s*--size=(\w+)|)(?:\s*--credit-card=(true)|)(?:\s*--time=(.+)|)$/, (res) ->

    imgAlt = res.match[1]
    size = res.match[2]
    creditCardFlag = res.match[3]
    crontime = if res.match[4] then res.match[4] else utils.convert2Crontime 'now'

    creditCard = undefined

    account = new Account
      db: 'arekai-da'
      clientId: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
      clientSecret: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
      redirectUrn: process.env.HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
      refreshToken: process.env.HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN

    account.getAccount res.message.user.name, 'supreme'
      .then (user) ->
        size = SupremeUtils.convertToSupremeSize size if size
        creditCard = new SupremeCreditCard user.creditCardCompany, user.creditCardNumber, user.creditCardMonth, user.creditCardYear, user.securitycode  if creditCardFlag
        supreme = new SupremeNew user.firstname, user.lastname, user.email, user.phonenumber, user.zipcode, user.state, user.city, user.address, imgAlt, creditCard, size
        name = "Buying Supreme New Item #{imgAlt}"
        fn = ->
          supreme.execute()

        task = new Task name, fn, crontime
        task.attach res

        res.send "Sir, yes, sir! 商品ID #{imgAlt} ﾉSupremeｦ購入ｼﾏｽ"

      .catch (err) ->
        res.send "```#{err.stack}```"
