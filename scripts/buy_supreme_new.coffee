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
#   arekai-da: buy supreme new "IMAGE_ALT_ATTRIBUTE" --size=s|m|l|xl --credit-card=false --from=1986-12-02T00:00:00 --interval=2 --times=10 --concurrency=2
#
# Author:
#   JumpeiArashi

Controller = require './controllers/buy_supreme_new'
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /buy\s+supreme\s+new\s+([\w_-]+)(?:\s*--size=(\w+)|)(?:\s*--credit-card=(false)|)(?:\s*--from=([T\d:-]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--times=([\d]+)|)(?:\s*--concurrency=([\d]+)|)$/, (res) ->
    #set true to default credit card flag
    interval = res.match[5] or 1
    times = res.match[6] or 20
    creditCardFlag = if not res.match[3] then true else false

    res.send 'Sir, yes, sir! 購入準備ｦｽｽﾒﾏｽ'

    controller = new Controller
      slackName: res.message.user.name
      creditCardFlag: creditCardFlag
      imgAlt: res.match[1]
      size: res.match[2]
      dryrunFlag: utils.isDryrun()
      room: res.message.room
      from: res.match[4]
      interval: interval
      times: times
      concurrency: res.match[7]

    controller.execute()
      .catch (err) ->
        errMessage = if err.hasOwnProperty('stack') then err.stack else err
        console.error errMessage
