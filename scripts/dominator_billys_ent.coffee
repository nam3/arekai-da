# Description
#   Purchase Biilys Ent Item with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator billys "ITEM_ID: e.g: 5455740001099" --from=1986-12-02T00:00:00 --concurrency=1 --attempts=64 --interval=4000 --users=user001,user002
#
# Author:
#   JumpeiArashi

Moment = require 'moment-timezone'
register = require('dominator').registerBillysEntJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+billys\s+([\w-]+)(?:\s+--from=([T\d:-]+)|)(?:\s+--concurrency=([\d]+)|)(?:\s+--attempts=([\d]+)|)(?:\s+--interval=([\d]+)|)(?:\s+--jobConcurrency=([\d]+)|)(?:\s+--users=([\w,]+)|)$/, (res) ->

    if res.match[7]
      userIds = res.match[7].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = utils.convert2JstDatetime(res.match[2])

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      return register(startDatetime, userId, res.match[1], Number(res.match[3]) or 1, Number(res.match[4]) or 3, Number(res.match[5]) or 2000, utils.isDryrun())
        .then ->
          res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'billys', resolve, reject
