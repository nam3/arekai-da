# Description
#   Rank Supreme Sold-Out Items
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: supreme-sold-out-ranking "PREVIOUS_SOLD_OUT_IMAGE_ALT_ATTRIBUTE" --from=1986-12-02T00:00:00 --max-item=20 --attempts=120 --interval=1000
#
# Author:
#   JumpeiArashi

Moment = require('moment-timezone')
register = require('dominator').registerToRankSupremeSoldOutItems
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /supreme-sold-out-ranking\s+"([\s\w_-]+)"(?:\s*--from=([T\d:-]+)|)(?:\s*--max-item=([\d]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)$/, (res) ->

    startDatetime = utils.convert2JstDatetime(res.match[2])

    return register(startDatetime, res.match[1], Number(res.match[3]) or 20, Number(res.match[4]) or 120, Number(res.match[5]) or 1000)
      .then () ->
        res.send "#{startDatetime}に対象のジョブをスタートします。"
      .catch (e) ->
        res.send "システムとのリンクを構築できません。エラー: #{e}"
