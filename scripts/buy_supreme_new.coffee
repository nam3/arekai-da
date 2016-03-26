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
#   arekai-da: buy supreme new "IMAGE_ALT_ATTRIBUTE" --size=s|m|l|xl --credit-card=false --time=CRONTIME
#
# Author:
#   JumpeiArashi

Controller = require './controllers/buy_supreme_new'
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /buy\s+supreme\s+new\s+([\w_-]+)(?:\s*--size=(\w+)|)(?:\s*--credit-card=(false)|)(?:\s*--from=([T\d:-]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--times=([\d]+)|)(?:\s*--concurrency=([\d]+)|)$/, (res) ->
    #set true to default credit card flag
    creditCardFlag = if not res.match[3] then true else false
    console.log res.match[4]

    controller = new Controller
      slackName: res.message.user.name
      creditCardFlag: creditCardFlag
      imgAlt: res.match[1]
      size: res.match[2]
      dryrunFlag: utils.isDryrun()
      room: res.message.room
      from: res.match[4]
      interval: res.match[5]
      times: res.match[6]
      concurrency: res.match[7]

    controller.execute()
      .catch (err) ->
        errMessage = if err.hasOwnProperty('stack') then err.stack else err
        console.error errMessage
