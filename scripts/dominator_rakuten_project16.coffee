# Description
#   Purchase Rakuten Project 1/6 Item with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator rakuten-project16 "ITEM_LINK" --from=1986-12-02T00:00:00 --payment-method=transfer|cod|seven-eleven|lawson  --attempts=1 --interval=1000 --concurrency=1
#
# Author:
#   JumpeiArashi

Moment = require('moment-timezone')
register = require('dominator').registerRakutenProject16Job
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+rakuten-project16\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--from=([T\d:-]+)|)(?:\s*--payment-method=(transfer|cod|seven-eleven|lawson)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--concurrency=([\d]+)|)$/, (res) ->

    userId = res.message.user.name
    startDatetime = Moment(res.match[2]).tz('Asia/Tokyo').format('YYYY-MM-DDTHH:mm:ss').toString()

    res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"

    Promise.all(utils.generatePromises(Number(res.match[6] or 1), ->
      return register(startDatetime, userId, res.match[1], res.match[3] || 'seven-eleven', Number(res.match[4]) || 10, Number(res.match[5]) || 500, utils.isDryrun());
    )).then ->
      res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"
    .catch (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"
