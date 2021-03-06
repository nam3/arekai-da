_ = require 'lodash'
Moment = require 'moment-timezone'
checkAccountExistence = require('dominator').checkAccountExistence

isValidDatetime = (datetime) ->

  if datetime.length < 18
    throw new Error "`#{datetime}` is invalid datetime format. e.g: 1986-12-02T00:00:00"

  unless Moment(datetime).isValid()
    throw new Error "`#{datetime}` is invalid datetime format. e.g: 1986-12-02T00:00:00"

  return datetime

nowPlus8Seconds = ->
  return Moment.tz('Asia/Tokyo').add(8, 'seconds').toDate()

convert2Crontime = (datetime) ->

  if datetime is 'now'
    return Moment.tz('Asia/Tokyo').add(8, 'seconds').toDate()

  return datetime

isDryRun = ->

  return if process.env.HUBOT_DRY_RUN and process.env.HUBOT_DRY_RUN.toLowerCase() is 'true' then true else false

assumeStringAsBoolean = (str) ->

  return if str.toLowerCase() is 'true' then true else false


generatePromises = (number, fn) ->
  return Array.prototype.map.call(new Buffer(number), fn)

getUsersExistenceOrThrow = (users, type, attempts, interval) ->
  return checkAccountExistence(users, type, attempts, interval).then((v) ->
    if _.includes(v, false)
      throw new Error('Found no existing user. Did you TYPO?? haha!')
    else
      return v
  )

handleMultipleUser = (users, type, resolve, reject, attempts, interval) ->
  return getUsersExistenceOrThrow users, type, attempts, interval
    .then (v) ->
      return Promise.all(_.map(users, resolve))
    .catch reject

convert2JstDatetime = (datetime) ->
  isValidDatetime(datetime)
  return datetime + '+09:00'

module.exports =
  isDryrun: isDryRun
  assumeStringAsBoolean: assumeStringAsBoolean
  isValidDatetime: isValidDatetime
  convert2Crontime: convert2Crontime
  nowPlus8Seconds: nowPlus8Seconds
  generatePromises: generatePromises
  getUsersExistenceOrThrow: getUsersExistenceOrThrow
  handleMultipleUser: handleMultipleUser
  convert2JstDatetime: convert2JstDatetime
