# Description
#   Purchase Rakuten Super Sale Item with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator rakuten-super-sale "ITEM_LINK" --from=1986-12-02T00:00:00 --type=e.g color,size: rakuten inventory_choice --payment-method=transfer|cod|seven-eleven|lawson  --attempts=1 --interval=1000 --concurrency=1 --users=user001,user002
#
# Author:
#   JumpeiArashi

Moment = require('moment-timezone')
register = require('dominator').registerRakutenSuperSaleJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+rakuten-super-sale\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--from=([T\d:-]+)|)(?:\s*--type=([\w]*)|)(?:\s*--payment-method=(transfer|cod|edy)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--concurrency=([\d]+)|)(?:\s*--users=([\w,_]+)|)$/, (res) ->

    if res.match[8]
      userIds = res.match[8].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = Moment(res.match[2]).tz('Asia/Tokyo').format('YYYY-MM-DDTHH:mm:ss').toString()

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"

      Promise.all(utils.generatePromises(Number(res.match[7] or 1), ->
        return register(startDatetime, userId, res.match[1], res.match[3], res.match[4] or 'transfer', Number(res.match[5]) or 16, Number(res.match[6]) or 10, utils.isDryrun())
      )).then ->
        res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'rakuten', resolve, reject
