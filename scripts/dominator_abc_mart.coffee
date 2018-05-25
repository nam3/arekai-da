# Description
#   Purchase abc-mart item
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator abc-mart --item-id=ITEM_ID --from=1986-12-02T00:00:00 --size=e.g:27.0 --concurrency=1 --attempts=1 --interval=1000 --job-concurrency=1 --users=user001,user002
#
# Author:
#   JumpeiArashi

Moment = require('moment-timezone')
register = require('dominator').registerAbcMartJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+abc-mart\s+(?:--item-id=([\w]+))(?:\s+--from=([T\d:-]+)|)(?:\s+--size=([\w.]+)|)(?:\s+--concurrency=([\d]+)|)(?:\s+--attempts=([\d]+)|)(?:\s+--interval=([\d]+)|)(?:\s+--job-concurrency=([\d]+)|)(?:\s+--users=([\w_,]+)|)$/, (res) ->

    if res.match[8]
      userIds = res.match[8].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = utils.convert2JstDatetime(res.match[2])

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      Promise.all(utils.generatePromises(Number(res.match[7] or 1), ->
        return register(startDatetime, userId, res.match[1], res.match[3] or '未指定', Number(res.match[4]) or 1, Number(res.match[5]) or 256, Number(res.match[6]) or 800, utils.isDryrun())
      )).then ->
        res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'abc_mart', resolve, reject
