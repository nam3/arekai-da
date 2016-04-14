# Description
#   Buy sea basket bag
#
# Configuration:
#   HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
#   HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
#   HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
#   HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN
#
# Commands:
#   arekai-da: buy sea bag --from=1986-12-02T00:00:00 --interval=2 --times=10 --concurrency=2
#
# Author:
#   JumpeiArashi

Controller = require './controllers/buy_sea_bag'
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /buy\s+sea\s+bag\s+(?:\s*--from=([T\d:-]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--times=([\d]+)|)(?:\s*--concurrency=([\d]+)|)$/, (res) ->

    interval = res.match[2] or 2
    times = res.match[3] or 10

    res.send 'Sir, yes, sir! 購入準備ｦｽｽﾒﾏｽ.'

    controller = new Controller
      slackName: res.message.user.name
      dryrunFlag: utils.isDryrun()
      room: res.message.room
      from: res.match[1]
      interval: interval
      times: times
      concurrency: Number res.match[4]

    controller.execute()
      .catch (err) ->
        message = if err.hasOwnProperty('stack') then err.stack else err
        console.error message
