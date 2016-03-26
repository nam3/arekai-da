Moment = require 'moment-timezone'
{Task} = require './task'
TaskCluster = require './task_cluster'

module.exports = (taskName, factory, notifier, params = {}) ->
  from = if params.from then Moment(params.from) else Moment()
  interval = if params.interval then params.interval else 1
  times = if params.times then params.times else 1
  concurrency = if params.concurrency then params.concurrency else 1

  executeDatetimes = [0..(times - 1)].map (time) ->
    return from.clone().add(interval * time, 'seconds').toDate()

  if concurrency > 1
    incrementsDatetime = [].concat executeDatetimes
    [2..concurrency].forEach ->
      executeDatetimes = executeDatetimes.concat incrementsDatetime

  tasks = executeDatetimes.map (datetime) ->
    new Task taskName, factory(), datetime

  taskCluster = new TaskCluster notifier, tasks
  tasks.forEach (task) ->
    task.attach [taskCluster]

  return taskCluster
