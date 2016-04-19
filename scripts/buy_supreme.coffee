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
#   arekai-da: buy supreme "IMAGE_ALT_ATTRIBUTE" --from=1986-12-02T00:00:00 --interval=2 --time=10 --concurrency=2
#
# Author:
#   JumpeiArashi

Controller = require './controllers/buy_supreme'
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /buy\s+supreme\s+([\w_-]+)(?:\s*--from=([T\d:-]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--times=([\d]+)|)(?:\s*--concurrency=([\d]+)|)$/, (res) ->

    interval = res.match[3] or 1
    times = res.match[4] or 20
    concurrency = res.match[5] or 1

    res.send 'Sir, yes, sir! 購入準備ｦｽｽﾒﾏｽ'

    controller = new Controller
      slackName: res.message.user.name
      imgAlt: res.match[1]
      dryrunFlag: utils.isDryrun()
      room: res.message.room
      from: res.match[2]
      interval: interval
      times: times
      concurrency: concurrency

    controller.execute()
      .catch (err) ->
        errMessage = if err.hasOwnProperty('stack') then err.stack else err
        console.error errMessage
