# Description
#   Purchase CJMart Item with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator cjmart "ITEM_URL" --from=1986-12-02T00:00:00 --attempts=64 --interval=1000 --concurrency=1 --users=user001,user002
#
# Author:
#   JumpeiArashi

_ = require('lodash')
Moment = require('moment-timezone')
Register = require('dominator').registerCJMartJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+cjmart\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--from=([T\d:-]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--concurrency=([\d]+)|)(?:\s*--users=([\w_,]+)|)$/, (res) ->

    if res.match[6]
      userIds = res.match[6].split(',')
    else
      userIds = res.message.user.name
    startDatetime = Moment(res.match[2]).tz('Asia/Tokyo').format('YYYY-MM-DDTHH:mm:ss').toString()

    utils.getUsersExistenceOrThrow(userIds, 'cjmart')
      .then (v) ->
        _.forEach userIds, (userId) ->
          res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
          Promise.all(utils.generatePromises(Number(res.match[5] or 1), ->
            return register(startDatetime, userId, res.match[1], Number(res.match[3]) or 64, Number(res.match[4]) or 1000, utils.isDryrun())
          )).then ->
            res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

      .catch (e) ->
        res.send "システムとのリンクを構築できません。エラー: #{e}"
