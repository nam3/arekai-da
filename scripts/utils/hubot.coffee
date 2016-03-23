Moment = require 'moment-timezone'

convert2Crontime = (datetime) ->

  if datetime is 'now'
    return Moment.tz('Asia/Tokyo').add(8, 'seconds').toDate()

  return datetime

is_dry_run = ->

  return if process.env.HUBOT_DRY_RUN and process.env.HUBOT_DRY_RUN.toLowerCase() is 'true' then true else false

module.exports =
  isDryrun: is_dry_run
  convert2Crontime: convert2Crontime
