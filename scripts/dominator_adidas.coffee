# Description
#   Purchase Adidas Shoe with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator adidas "ITEM_LINK" --size=e.g: 27.0, 27.5 --from=1986-12-02T00:00:00 --interval=1 --times=1 --concurrency=1
#
# Author:
#   JumpeiArashi

Moment = require('moment-timezone')
Register = require('dominator').GeneralBuyerTaskRegister
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+adidas\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--size=([\d.]+)|)(?:\s*--from=([T\d:-]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--times=([\d]+)|)(?:\s*--concurrency=([\d]+)|)$/, (res) ->

    userId = res.message.user.name

    res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"

    Promise.all(utils.generatePromises(Number(res.match[6] or 1), ->
      register = new Register(res.match[3], (res.match[4] or 1), (res.match[5] or 1), 'buy adidas shoe', userId, res.match[1], res.match[2], utils.isDryrun())
      return register.register()
    )).then ->
      res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"
    .catch (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"
