# Description
#   Buy(add to cart) Nike Air Presto
#
# Configuration:
#   HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
#   HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
#   HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
#   HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN
#
# Commands:
#   arekai-da: buy nike presto "TARGET_URL" --size=XXXS|XXS|XS|S|M|L|XL|XXL --time=CRONTIME
#
# Author:
#   JumpeiArashi

{Account} = require 'arekai-da-plugins'
NikeAirPresto = require('arekai-da-plugins').Nike.Presto
utils = require './utils/crontime'
{Task} = require './services/task'

module.exports = (robot) ->

  robot.respond /buy\s+nike\s+presto\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--size=([\w.]+)|)(?:\s*--time=(.+)|)$/, (res) ->

    url = res.match[1]
    size = res.match[2]
    crontime = if res.match[3] then res.match[3] else utils.convert2Crontime 'now'

    account = new Account
      db: 'arekai-da'
      clientId: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
      clientSecret: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
      redirectUrn: process.env.HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
      refreshToken: process.env.HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN

    account.getAccount res.message.user.name, 'nike'
      .then (user) ->
        nike = new NikeAirPresto user.name, user.password, url, size

        name = "Buying Nike Air Presto #{url}"
        fn = ->
          nike.execute()

        task = new Task name, fn, crontime
        task.attach res

        res.send "Sir, yes, sir! 当該ﾉNikeAirPrestoｦ#{size}ﾃﾞ購入ｼﾏｽ. #{url}"

      .catch (err) ->
        res.send err.message
