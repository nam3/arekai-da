# Description
#   Purchase Supreme Item with dominator when first launch each seasons
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator supreme-launch --from=1986-12-02T00:00:00 --category=all|new|jackets|shirts|tops_sweaters|sweatshirts|pants|t-shirts|hats|bags|accessories|shoes|skate --size=Small|Medium|Large|XLarge --payment-method=credit-card|cod --attempts=3 --interval=2000 --fetcher-mode=manual|auto --users=user001,user002
#
# Author:
#   JumpeiArashi

register = require('dominator').registerSupremeLaunch
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+supreme-launch\s+(?:\s*--from=([T\d:-]+)|)(?:\s*--category=([\w-]+)|)(?:\s*--size=([\w.]+)|)(?:\s*--payment-method=([\w-]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--fetcher-mode=([\w]+)|)(?:\s*--users=([\w,]+)|)$/, (res) ->

    if res.match[8]
      userIds = res.match[8].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = utils.convert2JstDatetime(res.match[1])

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      return register(startDatetime, userId, res.match[2], res.match[3] or undefined , res.match[4] or 'cod', Number(res.match[5]) or 3, Number(res.match[6]) or 2000, res.match[7] or 'manual', utils.isDryrun())
        .then ->
          res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'supreme', resolve, reject
