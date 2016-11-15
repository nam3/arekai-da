# Description
#   Purchase Nike Shoe at fake SP User-Agent with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator nike-with-sp "SHOE_URL" --from=1986-12-02T00:00:00 --size=e.g:27, 27.5 --attempts=10 --interval=2000(milliseconds) --concurrency=1 --users=user001,user002
#
# Author:
#   JumpeiArashi

Moment = require('moment-timezone')
register = require('dominator').registerNikeWithSPJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+nike-with-sp\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--from=([T\d:-]+)|)(?:\s*--size=([\w.]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--concurrency=([\d]+)|)(?:\s*--users=([\w,]+)|)$/, (res) ->

    if res.match[7]
      userIds = res.match[7].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = Moment(res.match[2]).tz('Asia/Tokyo').format('YYYY-MM-DDTHH:mm:ss').toString()

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      Promise.all(utils.generatePromises(Number(res.match[6] or 1), ->
        return register(startDatetime, userId, res.match[1], res.match[3], res.match[4], res.match[5], utils.isDryrun())
      )).then ->
        res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'nike', resolve, reject
