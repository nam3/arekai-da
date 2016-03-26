{expect} = require 'chai'

TaskCluster = require '../../../scripts/services/task_cluster'

NullNotifier = require '../../mock/null_notifier'

describe 'TaskCluster', ->

  describe '#checkAllTaskDone', ->
    cluster = undefined

    beforeEach ->
      cluster = new TaskCluster NullNotifier

    context 'when all tasks is not completed', ->

      it 'returns null', ->
        cluster.tasks = [{state: undefined}]
        expect cluster.checkAllTaskDone()
          .to.be.null

    context 'when some tasks is not completed', ->

      it 'returns null', ->
        cluster.tasks = [{state: undefined}, {state: false}]
        expect cluster.checkAllTaskDone()
          .to.be.null

    context 'when one task is completed', ->

      it 'returns true', ->
        cluster.tasks = [{state: undefined}, {state: true}]
        expect cluster.checkAllTaskDone()
          .to.be.true

    context 'when all tasks are failed', ->

      it 'returns false', ->
        cluster.tasks = [{state: false}, {state: false}]
        expect cluster.checkAllTaskDone()
          .to.be.false
