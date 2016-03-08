{expect} = require 'chai'

Task = require '../../../scripts/services/task'

describe 'describeTasks', ->

  context 'no task', ->

    it 'gets no tasks', ->

      expect Task.describeTasks().length
        .to.be.equal 0

  context 'one task', ->

    name = 'Test Task'
    task = undefined

    beforeEach ->
      fn = ->
        return new Promise (resolve, reject) ->
          resolve false

      task = new Task.Task name, fn

    afterEach ->
      task.end()

    it 'gets one task', ->

      tasks = Task.describeTasks()

      expect tasks.length
        .to.be.equal 1
      expect tasks[0]
        .to.have.all.keys 'id', 'name', 'crontime'

  context 'one task is end', ->

    name = 'Test Task'

    beforeEach ->
      fn = ->
        return new Promise (resolve, reject) ->
          resolve true

      task = new Task.Task name, fn, new Date()

    it 'gets no tasks', ->

      fn = ->
        expect Task.describeTasks()
          .to.be.equal 0

      setTimeout fn, 1000

describe 'Task', ->

  context 'when attaches one observer', ->

    task = undefined
    name = 'Test Task'
    res = {
      send: -> return
    }

    beforeEach ->
      fn = ->
        return new Promise (resolve, reject) ->
          resolve false

      task = new Task.Task name, fn, new Date()

    afterEach ->
      task.end()

    describe '#attach', ->

      context 'with res = response Object', ->

        it 'attaches observer', ->

          task.attach res

          expect task.observers[0]
            .to.be.equal res
