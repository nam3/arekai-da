# Description
#   Purchase Calif Item with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator calif "ITEM_LINK" --from=1986-12-02T00:00:00 --size=27.0 --attempts=1 --interval=1000 --concurrency=1
#
# Author:
#   JumpeiArashi

Moment = require('moment-timezone')
register = require('dominator').registerCalifJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+calif\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--from=([T\d:-]+)|)(?:\s*--size=([\d.]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--concurrency=([\d]+)|)$/, (res) ->

    userId = res.message.user.name
    startDatetime = Moment(res.match[2]).tz('Asia/Tokyo').format('YYYY-MM-DDTHH:mm:ss').toString()

    res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"

    return register(startDatetime, userId, res.match[1], res.match[3], Number(res.match[4]) or 64, Number(res.match[5]) or 10, Number(res.match[6]) or 16, utils.isDryrun())
      .then ->
        res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"
      .catch (e) ->
        res.send "システムとのリンクを構築できません。エラー: #{e}"
