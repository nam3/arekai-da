# Description
#   Purchase Feeet Item with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator feeet ITEM_LIST_URL --from=1986-12-02T00:00:00 --attempts=64 --interval=3000 --users=user001,user002
#
# Author:
#   JumpeiArashi

Moment = require 'moment-timezone'
register = require('dominator').registerFeeetJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+feeet\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--from=([T\d:-]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--users=([\w,]+)|)$/, (res) ->

    if res.match[5]
      userIds = res.match[5].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = utils.convert2JstDatetime(res.match[2])

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      return register(startDatetime, userId, res.match[1], Number(res.match[3]) or 3, Number(res.match[4]) or 3000, utils.isDryrun())
        .then ->
          res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'feeet', resolve, reject
