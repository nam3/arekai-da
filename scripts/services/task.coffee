#TODO reimplement this module by EventEmitter
Uuid = require 'node-uuid'
{CronJob} = require 'cron'

tasks = []

class Task

  constructor: (@name, execute, cronTime = '*/5 * * * * *') ->
    tasks.push this
    @state = undefined
    @observers = []
    @id = Uuid.v4()
    @job = new CronJob
      cronTime: cronTime
      onTick: =>
        execute()
          .then (result) =>
            @state = result
            @end()
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
      crontime: task.job.cronTime.source
    }

  return displayTasks

module.exports =
  Task: Task
  describeTasks: describeTasks
