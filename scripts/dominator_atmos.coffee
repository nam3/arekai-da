# Description
#   Purchase atmos item
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator atmos "ITEM_LINK" --from=1986-12-02T00:00:00 --type=e.g:240CM, WHITE, WHITE-270CM --payment-method=cod|credit-card --attempts=1 --interval=1000 --concurrency=1 --users=user001,user002
#
# Author:
#   JumpeiArashi

Moment = require('moment-timezone')
register = require('dominator').registerAtmosJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+atmos\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--from=([T\d:-]+)|)(?:\s*--type=([\w.]+)|)(?:\s*--payment-method=([\w-]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--concurrency=([\d]+)|)(?:\s*--users=([\w_,]+)|)$/, (res) ->

    if res.match[8]
      userIds = res.match[8].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = utils.convert2JstDatetime(res.match[2])

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      Promise.all(utils.generatePromises(Number(res.match[7] or 1), ->
        return register(startDatetime, userId, res.match[1], res.match[3], res.match[4] or 'cod', Number(res.match[5]) or 256, Number(res.match[6]) or 800, utils.isDryrun())
      )).then ->
        res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'atmos', resolve, reject
