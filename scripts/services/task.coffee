#TODO reimplement this module by EventEmitter
Uuid = require 'node-uuid'
{CronJob} = require 'cron'

tasks = []

class Task

  constructor: (@name, execute, cronTime) ->
    cronTime ?= '*/5 * * * * *'

    tasks.push this

    @observers = []
    @id = Uuid.v4()
    @job = new CronJob
      cronTime: cronTime
      onTick: =>
        execute()
          .then (result) =>
            if result
              @end()
          .catch (err) =>
            eMessage = if err.stack then err.stack else err
            @notify "```#{eMessage}```"

      start: true
      timeZone: 'Asia/Tokyo'

  end: =>
    tasks.forEach (task, index) =>
      if task.id is @id
        @job.stop()
        tasks.splice index, 1

        @notify """
          Completed following task :+1:
          ```
          #{@name}
          ```
        """

  attach: (res) =>
    @observers.push res

  notify: (message) =>
    @observers.forEach (observer) ->
      observer.send message

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
