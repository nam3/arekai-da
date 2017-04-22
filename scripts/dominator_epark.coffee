# Description
#   Reserve Epark shop
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator epark SHOP_LOCATION(e.g: umeda, ginza) --from=1986-12-02T00:00:00 --reservation-datetime=1986-12-02T11:00 --attempts=128 --interval=1000 --users=user001,user002
#
# Author:
#   JumpeiArashi

Moment = require 'moment-timezone'
register = require('dominator').registerEparkJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+epark\s+(umeda|shinsaibashi|ginza|harajuku)(?:\s*--from=([T\d:-]+)|)(?:\s*--reservation-datetime=([T\d:-]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--users=([\w,]+)|)$/, (res) ->

    if res.match[6]
      userIds = res.match[6].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = Moment(res.match[2]).tz('Asia/Tokyo').format('YYYY-MM-DDTHH:mm:ss').toString()

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      return register(startDatetime, userId, res.match[1], res.match[3], Number(res.match[4]) or 30 * 60 * 10, Number(res.match[5]) or 1000, utils.isDryrun())
        .then ->
          res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'epark', resolve, reject
