# Description
#   Purchase Rakuten Search with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator rakuten-search "KEYWORD" --search=SEARCH_URL --from=1986-12-02T00:00:00 --size=e.g:27.0,27.5 --polling-interval=4096 --attempts=64 --interval=10 --users=user001,user002
#
# Author:
#   JumpeiArashi

Moment = require 'moment-timezone'
register = require('dominator').registerRakutenSearchJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+rakuten-search\s+"([\s\w\/_'\-]+)"(?:\s*--search=(https?:\/\/[\w/:%#$&?()~.=+_-]+))(?:\s*--from=([T\d:-]+)|)(?:\s*--size=([\w\.]+)|)(?:\s*--polling-interval=([\w\.]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--users=([\w,]+)|)$/, (res) ->

    if res.match[8]
      userIds = res.match[8].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = utils.convert2JstDatetime(res.match[3])

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      return register(startDatetime, userId, res.match[1], res.match[2], res.match[4] or undefined, Number(res.match[5]) or 4096, Number(res.match[6]) or 3, Number(res.match[7]) or 2000, utils.isDryrun())
        .then ->
          res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'rakuten', resolve, reject
