# Description
#   Purchase Isetan Item with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator isetan "ITEM_URL"(required https) --from=1986-12-02T00:00:00 --color=SAND,シロxミドリ --size=e.g:27.0,27.5 --attempts=64 --interval=10
#
# Author:
#   JumpeiArashi

register = require('dominator').registerIsetanJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+isetan\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--from=([T\d:-]+)|)(?:\s*--color=([\w]+)|)(?:\s*--size=([\w\.]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)$/, (res) ->

    userId = res.message.user.name

    res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"

    try
      return register(res.match[2], userId, res.match[1], res.match[3], res.match[4] or undefined, Number(res.match[5]) or 3, Number(res.match[6]) or 2000, utils.isDryrun())
        .then ->
          res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"
        .catch (e) ->
          res.send "システムとのリンクを構築できません。エラー: #{e}"
    catch e
      res.send "システムとのリンクを構築できません。エラー: #{e}"
