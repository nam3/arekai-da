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

Controller = require './controllers/buy_supreme_new'
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /buy\s+supreme\s+new\s+([\w_-]+)(?:\s*--size=(\w+)|)(?:\s*--credit-card=(false)|)(?:\s*--time=(.+)|)$/, (res) ->

    #set true to default credit card flag
    creditCardFlag = if not res.match[3] then true else false
    crontime = if res.match[4] then res.match[4] else utils.convert2Crontime 'now'

    controller = new Controller
      slackName: res.message.user.name
      creditCardFlag: creditCardFlag
      imgAlt: res.match[1]
      size: res.match[2]
      cronTime: crontime
      dryrunFlag: utils.isDryrun()
      room: res.message.room

    controller.execute()
