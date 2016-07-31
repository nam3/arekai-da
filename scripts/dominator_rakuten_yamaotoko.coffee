# Description
#   Purchase Rakuten Yamaotoko Shoe with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator rakuten-yamaotoko "ITEM_LINK" --size=e.g:27.0, 27.5 --from=1986-12-02T00:00:00 --attempts=1 --interval=1000 --concurrency=1
#
# Author:
#   JumpeiArashi

Moment = require('moment-timezone')
register = require('dominator').registerRakutenYamaotokoJob
utils = require './utils/hubot'

module.exports = (robot) ->

  # At this point, sibyl.RakutenYamaotokoBuyer can't choose payment method, edy only.
  robot.respond /dominator\s+rakuten-yamaotoko\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--size=([\d.]+)|)(?:\s*--from=([T\d:-]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--concurrency=([\d]+)|)$/, (res) ->

    userId = res.message.user.name
    startDatetime = Moment(res.match[3]).tz('Asia/Tokyo').format('YYYY-MM-DDTHH:mm:ss').toString()

    res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"

    Promise.all(utils.generatePromises(Number(res.match[6] or 1), ->
      return register(startDatetime, userId, res.match[1], res.match[2], 'edy', Number(res.match[4]) or 8, Number(res.match[5]) or 250, utils.isDryrun())
    )).then ->
      res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"
    .catch (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"