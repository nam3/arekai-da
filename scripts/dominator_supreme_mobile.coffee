# Description
#   Purchase Supreme Mobile Item with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator supreme-mobile "SEARCH KEYWORD"(case sensitive) --from=1986-12-02T00:00:00 --color=Black(optional) --size=Small,10(optional) --attempts=200 --interval=2000 --recaptcha-mode=manual|auto --users=user001,user002
#
# Author:
#   JumpeiArashi

Moment = require 'moment-timezone'
register = require('dominator').registerSupremeMobileJob
utils = require './utils/hubot'

module.exports = (robot) ->

  robot.respond /dominator\s+supreme-mobile\s+"([\s\w\/_-]+)"(?:\s*--from=([T\d:-]+)|)(?:\s*--color=([\w]+)|)(?:\s*--size=([\w\.]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--recaptcha-mode=([\w]+)|)(?:\s*--users=([\w,]+)|)$/, (res) ->

    console.log('fetcher log', res.match[7])
    if res.match[8]
      userIds = res.match[8].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = utils.convert2JstDatetime(res.match[2])

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      return register(startDatetime, userId, res.match[1], res.match[3], res.match[4] or undefined, Number(res.match[5]) or 3, Number(res.match[6]) or 2000, res.match[7], utils.isDryrun())
        .then ->
          res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'supreme', resolve, reject
