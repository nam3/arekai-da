# Description
#   Purchase toysrus item with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator toysrus "ITEM_LINK" --from=1986-12-02T00:00:00 --attempts=248 --interval=2048 --concurrency=1 --users=user001,user002
#
# Author:
#   JumpeiArashi

register = require('dominator').registerToysrusJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+toysrus\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--from=([T\d:-]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--concurrency=([\d]+)|)(?:\s*--users=([\w_,]+)|)$/, (res) ->

    if res.match[6]
      userIds = res.match[6].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = utils.convert2JstDatetime(res.match[2])

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      Promise.all(utils.generatePromises(Number(res.match[5] or 1), ->
        return register(startDatetime, userId, res.match[1], Number(res.match[3]) or 128, Number(res.match[4]) or 300, utils.isDryrun())
      )).then ->
        res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'toysrus', resolve, reject
