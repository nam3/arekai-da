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

  tasks = executeDatetimes.map (datetime) ->
    new Task taskName, factory(), datetime

  if concurrency > 1
    incrementalTasks = [].concat tasks
    [2..concurrency].forEach ->
      tasks = tasks.concat incrementalTasks

  return new TaskCluster notifier, tasks
