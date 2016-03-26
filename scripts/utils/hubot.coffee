Moment = require 'moment-timezone'

isValidDatetime = (datetime) ->

  if datetime.length < 18
    throw new Error "`#{datetime}` is invalid datetime format. e.g: 1986-12-02T00:00:00"

  unless Moment(datetime).isValid()
    throw new Error "`#{datetime}` is invalid datetime format. e.g: 1986-12-02T00:00:00"

  return datetime

nowPlus8Seconds = () ->
  return Moment.tz('Asia/Tokyo').add(8, 'seconds').toDate()

convert2Crontime = (datetime) ->

  if datetime is 'now'
    return Moment.tz('Asia/Tokyo').add(8, 'seconds').toDate()

  return datetime

is_dry_run = ->

  return if process.env.HUBOT_DRY_RUN and process.env.HUBOT_DRY_RUN.toLowerCase() is 'true' then true else false

module.exports =
  isDryrun: is_dry_run
  isValidDatetime: isValidDatetime
  convert2Crontime: convert2Crontime
  nowPlus8Seconds: nowPlus8Seconds
