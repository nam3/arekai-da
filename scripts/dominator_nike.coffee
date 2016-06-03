# Description
#   Purchase Supreme Item with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator nike "SHOE_URL" --size=e.g:27, 27.5 --from=1986-12-02T00:00:00 --interval=2 --times=10
#
# Author:
#   JumpeiArashi

Register = require('dominator').GeneralBuyerTaskRegister
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+nike\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--size=([\d.]+)|)(?:\s*--from=([T\d:-]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--times=([\d]+)|)$/, (res) ->

    userId = res.message.user.name

    res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"

    register = new Register(res.match[3], (res.match[4] or 2), (res.match[5] or 8), 'buy nike shoe', userId, res.match[1], res.match[2], utils.isDryrun())
    register.register()
      .then ->
        res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"
      .catch (err) ->
        res.send "システムとのリンクを構築できません。エラー: #{err}"
