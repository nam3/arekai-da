#TODO reimplement this module by EventEmitter
{CronJob} = require 'cron'
Uuid = require 'node-uuid'
Moment = require 'moment-timezone'

tasks = []

class Task

  constructor: (@name, execute, cronTime = '*/5 * * * * *') ->
    tasks.push this
    @state = undefined
    @observers = []
    @id = Uuid.v4()
    @datetime = Moment(cronTime).toDate()
    @job = new CronJob
      cronTime: cronTime
      onTick: =>
        execute()
          .then (result) =>
            @state = result
            @end("at #{@datetime}")
          .catch (err) =>
            @state = false
            message = if err.stack then err.stack else err
            @end(message)
      start: true
      timeZone: 'Asia/Tokyo'

  end: (message) =>
    tasks.forEach (task, index) =>
      if task.id is @id
        @job.stop()
        tasks.splice index, 1
        @notify(message)

  attach: (observers) =>
    @observers = @observers.concat observers

  notify: (message) =>
    @observers.forEach (observer) ->
      observer.emit 'done', message

describeTasks = ->

  displayTasks = tasks.map (task) ->

    return {
      id: task.id
      name: task.name
      datetime: task.datetime
    }

  return displayTasks

resetTasks = ->
  tasks.forEach (task) ->
    task.end()
  tasks = []

module.exports =
  Task: Task
  describeTasks: describeTasks
  resetTasks: resetTasks
