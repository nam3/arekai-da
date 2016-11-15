# Description
#   Purchase Medicom Toy Item with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator medicomtoy "ITEM_LINK" --from=1986-12-02T00:00:00 --concurrency=1 --users=user001,user002
#
# Author:
#   JumpeiArashi

_ = require('lodash')
Moment = require('moment-timezone')
register = require('dominator').registerMedicomToyItemJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+medicomtoy\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--from=([T\d:-]+)|)(?:\s*--concurrency=([\d]+)|)(?:\s*--users=([\w_,]+)|)$/, (res) ->

    if res.match[4]
      userIds = res.match[4].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = Moment(res.match[2]).tz('Asia/Tokyo').format('YYYY-MM-DDTHH:mm:ss').toString()

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      Promise.all(utils.generatePromises(Number(res.match[3] or 1), ->
        return register(startDatetime, userId, res.match[1], utils.isDryrun())
      )).then ->
        res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'medicomtoy', resolve, reject
