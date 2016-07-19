# Description
#   Purchase Adidas Shoe with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator adidas "ITEM_LINK" --size=e.g: 27.0, 27.5 --from=1986-12-02T00:00:00 --attempts=4096 --interval=3000 --concurrency=1
#
# Author:
#   JumpeiArashi

Moment = require('moment-timezone')
register = require('dominator').registerAdidasShoeJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+adidas\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--size=([\d.]+)|)(?:\s*--from=([T\d:-]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--concurrency=([\d]+)|)$/, (res) ->

    userId = res.message.user.name
    startDatetime = Moment(res.match[3]).tz('Asia/Tokyo').format('YYYY-MM-DDTHH:mm:ss').toString()

    res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"

    Promise.all(utils.generatePromises(Number(res.match[6] or 1), ->
      return register(startDatetime, userId, res.match[1], res.match[2] or '27.0', Number(res.match[4]) or 4096, Number(res.match[5]) or 3000, utils.isDryrun())
    )).then ->
      res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"
    .catch (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"
