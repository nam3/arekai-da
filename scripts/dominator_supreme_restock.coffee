# Description
#   Purchase Supreme Restocked Item with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator supreme-restock IMAGE_NUMBER --from=1986-12-02T00:00:00 --category=jackets|shirts|tops_sweaters|sweatshirts|pants|t-shirts|hats|bags|accessories|shoes|skate --size=Small|Medium|Large|XLarge --payment-method=credit-card|cod --attempts=3 --interval=2000 --max-checkout-delay=6000 --fetcher-mode=manual|auto --users=user001,user002
#
# Author:
#   JumpeiArashi

register = require('dominator').registerSupremeRestockJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+supreme-restock\s+(\d+)(?:\s*--from=([T\d:-]+)|)(?:\s*--category=([\w-]+)|)(?:\s*--size=([\w.]+)|)(?:\s*--payment-method=([\w-]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--max-checkout-delay=([\d]+)|)(?:\s*--fetcher-mode=([\w]+)|)(?:\s*--users=([\w,]+)|)$/, (res) ->

    if res.match[10]
      userIds = res.match[10].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = utils.convert2JstDatetime(res.match[2])

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      return register(startDatetime, userId, res.match[1], res.match[3], res.match[4] or undefined, res.match[5] or 'credit-card', Number(res.match[6]) or 3, Number(res.match[7]) or 2000, Number(res.match[8]) or 6000, res.match[9], utils.isDryrun())
        .then ->
          res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'supreme', resolve, reject
