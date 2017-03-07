# Description
#   Purchase Rakuten with all method which is integrated Browser
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator rakuten-full-browser "ITEM_LINK" --inventory-id=e.g: 12345 (not human-friendly) --from=1986-12-02T00:00:00 --attempts=1 --interval=1000 --concurrency=1 --users=user001,user002
#
# Author:
#   JumpeiArashi

Moment = require('moment-timezone')
register = require('dominator').registerRakutenFullBrowserJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+rakuten-full-browser\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--inventory-id=([\w.]+)|)(?:\s*--from=([T\d:-]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--concurrency=([\d]+)|)(?:\s*--users=([\w_,]+)|)$/, (res) ->

    if res.match[7]
      userIds = res.match[7].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = Moment(res.match[3]).tz('Asia/Tokyo').format('YYYY-MM-DDTHH:mm:ss').toString()

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      Promise.all(utils.generatePromises(Number(res.match[6] or 1), ->
        return register(startDatetime, userId, res.match[1], res.match[2], Number(res.match[4]) or 8, Number(res.match[5]) or 250, utils.isDryrun())
      )).then ->
        res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'rakuten', resolve, reject
