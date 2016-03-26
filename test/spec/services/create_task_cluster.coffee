{expect} = require 'chai'

createTaskCluster = require '../../../scripts/services/create_task_cluster'

describe 'create_task_cluster', ->

  factory = ->
    return () ->
      return new Promise (resolve, reject) ->
        resolve true
  taskName = 'Test Task'
  datetime = "1986-12-02T00:00:00"

  context 'default parameters', ->

    it 'returns cluster which has one task', ->
      expect createTaskCluster(taskName, factory).tasks.length
        .to.be.equal 1

  context 'with interval = "2", times = "10" ', ->

    it 'returns cluster which has 10 tasks', ->
      params =
        interval: 2
        times: 10
      expect createTaskCluster(taskName, factory, null, params).tasks.length
        .to.be.equal 10

  context 'with concurrency = "2" ', ->

    it 'returns cluster which has 2 tasks', ->
      params =
        concurrency: 2
      expect createTaskCluster(taskName, factory, null, params).tasks.length
        .to.be.equal 2

  context 'with from = "00:00:00", interval = "2", times = "2" and concurrency = "2"', ->

    it 'returns cluster which has tasks on tick 00:00:00, 00:00:02, 00:00:04, 00:00::06 * 2', ->
      params =
        from: datetime
        interval: 2
        times: 4
        concurrency: 2
      cluster = createTaskCluster(taskName, factory, null, params)
      clusterTaskDatetimes = cluster.tasks.map (task) ->
        taskCronTime = task.job.cronTime.source.toDate()
        return "0#{taskCronTime.getHours()}:0#{taskCronTime.getMinutes()}:0#{taskCronTime.getSeconds()}"

      expect clusterTaskDatetimes
        .to.be.deep.equal ['00:00:00', '00:00:02', '00:00:04', '00:00:06', '00:00:00', '00:00:02', '00:00:04', '00:00:06']
