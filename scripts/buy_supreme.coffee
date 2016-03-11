# Description
#   Purchase Supreme Item
#
# Configuration:
#   HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
#   HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
#   HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
#   HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN
#
# Commands:
#   arekai-da: buy supreme "TARGET_URL" --time=CRONTIME
#
# Author:
#   JumpeiArashi

{Account} = require 'arekai-da-plugins'
Supreme = require('arekai-da-plugins').Supreme.DirectLink
utils = require './utils/crontime'
{Task} = require './services/task'

module.exports = (robot) ->

  robot.respond /buy\s+supreme\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--time=(.+)|)$/, (res) ->

    url = res.match[1]
    crontime = if res.match[2] then res.match[2] else utils.convert2Crontime 'now'

    account = new Account
      db: 'arekai-da'
      clientId: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
      clientSecret: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
      redirectUrn: process.env.HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
      refreshToken: process.env.HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN

    account.getAccount res.message.user.name, 'supreme'
      .then (user) ->
        supreme = new Supreme user.firstname, user.lastname, user.email, user.phonenumber, user.zipcode, user.state, user.city, user.address, url

        name = "Buying Supreme Item #{url}"
        fn = ->
          supreme.execute()

        task = new Task name, fn, crontime
        task.attach res

        res.send "Sir, yes, sir! Supremeﾉ商品ｦ購入ｼﾏｽ. #{url}"

      .catch (err) ->
        res.send "```#{err.stack}```"
