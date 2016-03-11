# Description
#   Buy(add to cart) Nike Shoe
#
# Configuration:
#   HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
#   HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
#   HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
#   HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN
#
# Commands:
#   arekai-da: buy nike shoe "TARGET_URL" --size=SIZE(e.g: 27, 27.5) --time=CRONTIME
#
# Author:
#   JumpeiArashi

{Account} = require 'arekai-da-plugins'
NikeShoe = require('arekai-da-plugins').Nike.Shoe
utils = require './utils/crontime'
{Task} = require './services/task'

module.exports = (robot) ->

  robot.respond /buy\s+nike\s+shoe\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--size=([\d.]+)|)(?:\s*--time=(.+)|)$/, (res) ->

    url = res.match[1]
    size = res.match[2] or '27'
    crontime = if res.match[3] then res.match[3] else utils.convert2Crontime 'now'

    account = new Account
      db: 'arekai-da'
      clientId: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
      clientSecret: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
      redirectUrn: process.env.HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
      refreshToken: process.env.HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN

    account.getAccount res.message.user.name, 'nike'
      .then (user) ->
        nike = new NikeShoe user.name, user.password, url, size

        name = "Buying Nike Shoe #{url}"
        fn = ->
          nike.execute()

        task = new Task name, fn, crontime
        task.attach res

        res.send "Sir, yes, sir! 当該ﾉNikeｽﾆｰｶｰｦ#{size}ﾃﾞ購入ｼﾏｽ. #{url}"

      .catch (err) ->
        res.send err.message
