# Description
#   Purchase Fujiya Item with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator fujiya "ITEM_URL" --from=1986-12-02T00:00:00 --attempts=128 --interval=1000 --concurrency=1 users=user001,user002
#
# Author:
#   JumpeiArashi

Register = require('dominator').registerFujiyaJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+fujiya\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--from=([T\d:-]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--concurrency=([\d]+)|)(?:\s*--users=([\w_,]+)|)$/, (res) ->

    userId = res.message.user.name

    res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"

    Promise.all(utils.generatePromises(Number(res.match[5] or 1), ->
      register = new Register(res.match[3], (res.match[4] or 2), (res.match[5] or 8), 'buy fujiya item', userId, res.match[1], res.match[2], utils.isDryrun())
      return register.register()
    )).then ->
      res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"
    .catch (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"
