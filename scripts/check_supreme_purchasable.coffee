# Description
#   Check Supreme Item Purchasable
#
# Commands:
#   arekai-da: check supreme "PROXY_HOST:PROXY_PORT" "IMAGE_ALT_ATTRIBUTE" --from=1986-12-02T00:00:00 --interval=2 --time=10 --concurrency=2
#
# Author:
#   JumpeiArashi

Controller = require './controllers/check_supreme_purchasable'

module.exports = (robot) ->

  robot.respond /check\s+supreme\s+([\w_.:-]+)\s+([\w_-]+)(?:\s*--from=([T\d:-]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--times=([\d]+)|)(?:\s*--concurrency=([\d]+)|)$/, (res) ->

    interval = res.match[4] or 2
    times = res.match[5] or 10
    concurrency = res.match[6] or 1

    res.send '商品ﾉ販売開始時刻ｦ調査ｼﾏｽ'

    controller = new Controller
      slackName: res.message.user.name
      proxyServerString: res.match[2]
      imgAlt: res.match[1]
      room: res.message.room
      from: res.match[3]
      interval: interval
      times: times
      concurrency: concurrency

    controller.execute()
