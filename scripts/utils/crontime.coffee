Moment = require 'moment-timezone'

convert2Crontime = (datetime) ->

  if datetime is 'now'
    return Moment.tz('Asia/Tokyo').add(16, 'seconds').toDate()

  return datetime

module.exports =
  convert2Crontime: convert2Crontime