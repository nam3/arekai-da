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
#   arekai-da: buy nike shoe "TARGET_URL" --size=SIZE(e.g: 27, 27.5) --purchase=true --from=1986-12-02T00:00:00 --interval=2 --times=10 --concurrency=2
#
# Author:
#   JumpeiArashi

Controller = require './controllers/buy_nike_shoe'
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /buy\s+nike\s+shoe\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--size=([\d.]+)|)(?:\s*--purchase=([\w]+)|)(?:\s*--from=([T\d:-]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--times=([\d]+)|)(?:\s*--concurrency=([\d]+)|)$/, (res) ->

    size = res.match[2] or '27'
    interval = res.match[5] or 2
    times = res.match[6] or 10
    purchaseFlag = if res.match[3] and res.match[3].toLowerCase() is 'true' then true else false

    res.send 'Sir, yes, sir! 購入準備ｦｽｽﾒﾏｽ.'

    controller = new Controller
      slackName: res.message.user.name
      url: res.match[1]
      size: size
      dryrunFlag: utils.isDryrun()
      purchaseFlag: purchaseFlag
      room: res.message.room.name
      from: res.match[4]
      interval: interval
      times: times
      concurrency: Number res.match[7]

    controller.execute()
      .catch (err) ->
        message = if err.hasOwnProperty('stack') then err.stack else err
        console.error message
