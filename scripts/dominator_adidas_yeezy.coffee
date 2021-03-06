# Description
#   Purchase Adidas Shoe with browser integration
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator adidas-yeezy --item1=ITEM_URL --item2=ITEM_URL ..snip.. --item8=ITEM_URL --size=e.g: 27.0, 27.5 --from=1986-12-02T00:00:00 --attempts=128 --interval=200 --checkout-concurrency=4 --users=user001,user002
#
# Author:
#   JumpeiArashi

_ = require('lodash')
Moment = require('moment-timezone')
register = require('dominator').registerAdidasYeezyJob
utils = require './utils/hubot'

module.exports = (robot) ->

# coffeelint: disable=max_line_length
  robot.respond /dominator\s+adidas-yeezy\s+(?:\s*--item1=(https?:\/\/[\w/:%#$&?()~.=+_-]+)|)(?:\s*--item2=(https?:\/\/[\w/:%#$&?()~.=+_-]+)|)(?:\s*--item3=(https?:\/\/[\w/:%#$&?()~.=+_-]+)|)(?:\s*--item4=(https?:\/\/[\w/:%#$&?()~.=+_-]+)|)(?:\s*--item5=(https?:\/\/[\w/:%#$&?()~.=+_-]+)|)(?:\s*--item6=(https?:\/\/[\w/:%#$&?()~.=+_-]+)|)(?:\s*--item7=(https?:\/\/[\w/:%#$&?()~.=+_-]+)|)(?:\s*--item8=(https?:\/\/[\w/:%#$&?()~.=+_-]+)|)(?:\s*--size=([\d.]+)|)(?:\s*--from=([T\d:-]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--checkout-concurrency=([\d]+)|)(?:\s*--users=([\w,]+)|)$/, (res) ->

    if res.match[14]
      userIds = res.match[14].split(',')
    else
      userIds = [res.message.user.name]

    startDatetime = utils.convert2JstDatetime(res.match[10])
    itemIds = _.compact res.match[1..8]

    resolve = (userId) ->
      res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"
      return register(startDatetime, userId, itemIds, res.match[9] or '27.0', Number(res.match[11]) or 8, Number(res.match[12]) or 20000, Number(res.match[13]) or 4, utils.isDryrun(), Moment(startDatetime).subtract(_.random(1000 * 60 * 6, 1000 * 60 * 8), 'milliseconds').toDate())
        .then ->
          res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"

    reject = (e) ->
      res.send "システムとのリンクを構築できません。エラー: #{e}"

    utils.handleMultipleUser userIds, 'adidas', resolve, reject
