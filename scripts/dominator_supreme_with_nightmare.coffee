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
#   arekai-da: dominator supreme --item1="IMAGE_ALT_ATTRIBUTE" --item2="IMAGE_ALT_ATTRIBUTE" --item3="IMAGE_ALT_ATTRIBUTE" --item4="IMAGE_ALT_ATTRIBUTE" --from=1986-12-02T00:00:00 --size=S|M|L|XL --payment-method=credit-card|cod --fetcher-type=manual|2captcha|ignore --attempts=3 --interval=2000 --max-checkout-delay=6000 --users=user001,user002
#
# Author:
#   JumpeiArashi

_ = require('lodash')
Moment = require('moment-timezone')
register = require('dominator').registerSupremeItemWithNightmareJob
utils = require './utils/hubot'

module.exports = (robot) ->

# coffeelint: disable=max_line_length
  robot.respond /dominator\s+supreme\s+(?:\s*--item1="([\s\w:_-]+)"|)(?:\s*--item2="([\s\w:_-]+)"|)(?:\s*--item3="([\s\w:_-]+)"|)(?:\s*--item4="([\s\w:_-]+)"|)(?:\s*--from=([T\d:-]+)|)(?:\s*--size=([\w.]+)|)(?:\s*--payment-method=([\w-]+)|)(?:\s*--fetcher-type=([\w-]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--max-checkout-delay=([\d]+)|)(?:\s*--users=([\w,]+)|)$/, (res) ->

    if res.match[12]
      userIds = res.match[12].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = utils.convert2JstDatetime(res.match[5])
    itemIds = _.compact res.match[1..4]

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      return register(startDatetime, userId, itemIds, res.match[6], res.match[7] or 'credit-card', res.match[8] or 'manual', Number(res.match[9]) or 3, Number(res.match[10]) or 2000, Number(res.match[11]) or 6000, utils.isDryrun())
        .then ->
          res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'supreme', resolve, reject
