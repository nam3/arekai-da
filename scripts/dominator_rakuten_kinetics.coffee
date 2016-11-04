# Description
#   Purchase Rakuten Kinetics Shoe with dominator
#
# Configuration:
#   MONGODB_USER
#   MONGODB_PASSWORD
#   MONGODB_HOST
#   MONGODB_PORT
#   MONGODB_DATABASE
#
# Commands:
#   arekai-da: dominator rakuten-kinetics "ITEM_LINK" --size=e.g:27.0, 27.5 --from=1986-12-02T00:00:00 --attempts=1 --interval=1000 --concurrency=1 --users=user001,user002
#
# Author:
#   JumpeiArashi

Moment = require('moment-timezone')
register = require('dominator').registerRakutenKineticsJob
utils = require './utils/hubot'

module.exports = (robot) ->

  # At this point, sibyl.RakutenMitaSneakersBuyer can't choose payment method, edy only.
  robot.respond /dominator\s+rakuten-kinetics\s+(https?:\/\/[\w/:%#$&?()~.=+_-]+)(?:\s*--size=([\d.]+)|)(?:\s*--from=([T\d:-]+)|)(?:\s*--attempts=([\d]+)|)(?:\s*--interval=([\d]+)|)(?:\s*--concurrency=([\d]+)|)(?:\s*--users=([\w_,]+)|)$/, (res) ->

    if res.match[7]
      userIds = res.match[7].split(',')
    else
      userIds = [res.message.user.name]
    startDatetime = Moment(res.match[3]).tz('Asia/Tokyo').format('YYYY-MM-DDTHH:mm:ss').toString()

    utils.getUsersExistenceOrThrow(userIds, 'rakuten')
      .then (v) ->
        userIds.forEach (userId) ->
          res.send "携帯型心理診断鎮圧執行システムドミネーター、起動しました。ユーザー認証、#{userId}。"

          Promise.all(utils.generatePromises(Number(res.match[6] or 1), ->
            try
              return register(startDatetime, userId, res.match[1], res.match[2], 'cod', Number(res.match[4]) or 8, Number(res.match[5]) or 250, utils.isDryrun())
            catch e
              return Promise.reject e
          )).then ->
            res.send "適正ユーザーです。慎重に照準を定め対象を排除してください。"
      .catch (e) ->
        res.send "システムとのリンクを構築できません。エラー: #{e}"
