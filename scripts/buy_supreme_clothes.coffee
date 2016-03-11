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
#   arekai-da: buy supreme clothes "TARGET_URL" --size=s|m|l|xl --time=CRONTIME
#
# Author:
#   JumpeiArashi

{Account} = require 'arekai-da-plugins'
{SupremeClothes} = require('arekai-da-plugins').Supreme.Clothes
SupremeUtils = require './utils/supreme'
utils = require './utils/crontime'
{Task} = require './services/task'

module.exports = (robot) ->

  robot.respond /buy\s+supreme\s+clothes\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--size=(\w+)|)(?:\s*--time=(.+)|)$/, (res) ->

    url = res.match[1]
    size = res.match[2] or 's'
    crontime = if res.match[3] then res.match[3] else utils.convert2Crontime 'now'
    size = SupremeUtils.convertToSupremeSize size

    account = new Account
      db: 'arekai-da'
      clientId: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
      clientSecret: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
      redirectUrn: process.env.HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
      refreshToken: process.env.HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN

    account.getAccount res.message.user.name, 'supreme'
      .then (user) ->
        supreme = new SupremeClothes user.firstname, user.lastname, user.email, user.phonenumber, user.zipcode, user.state, user.city, user.address, url, null, size

        name = "Buying Supreme Clothes #{url}"
        fn = ->
          supreme.execute()

        task = new Task name, fn, crontime
        task.attach res

        res.send "Sir, yes, sir! Supremeﾉ洋服ｦｻｲｽﾞ#{size}購入ｼﾏｽ. #{url}"

      .catch (err) ->
        res.send "```#{err.stack}```"
