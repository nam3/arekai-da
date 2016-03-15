# Description
#   Purchase Adidas Shoe
#
# Configuration:
#   HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
#   HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
#   HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
#   HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN
#
# Commands:
#   arekai-da: buy adidas shoe "TARGET_URL" --size=SIZE(e.g: 27.0, 27.5) --time=CRONTIME
#
# Author:
#   JumpeiArashi

{Account} = require 'arekai-da-plugins'
AdidasShoe = require('arekai-da-plugins').Adidas.Shoe
utils = require './utils/crontime'
{Task} = require './services/task'

module.exports = (robot) ->

  robot.respond /buy\s+adidas\s+shoe\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--size=([\d.]+)|)(?:\s*--time=(.+)|)$/, (res) ->

    url = res.match[1]
    size = res.match[2] or '27.5'
    crontime = if res.match[3] then res.match[3] else utils.convert2Crontime 'now'

    account = new Account
      db: 'arekai-da'
      clientId: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
      clientSecret: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
      redirectUrn: process.env.HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
      refreshToken: process.env.HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN

    account.getAccount res.message.user.name, 'adidas'
      .then (user) ->
        nike = new AdidasShoe user.name, user.password, url, size

        name = "Buying Adidas Shoe #{url}"
        fn = ->
          nike.execute()

        task = new Task name, fn, crontime
        task.attach res

        res.send "Sir, yes, sir! 当該ﾉAdidasｽﾆｰｶｰｦ#{size}ﾃﾞ購入ｼﾏｽ. #{url}"

      .catch (err) ->
        res.send err.message
