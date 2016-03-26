{EventEmitter} = require('events')

module.exports = class TaskCluster extends EventEmitter

  constructor: (@notifier, @tasks = []) ->
    super()
    @.on('done', @checkAllTaskDone)

  notify: (message) ->
    @notifier.send message

  checkAllTaskDone: (message) =>
    taskResults = @tasks.map (task) ->
      if task.state is undefined
        return null

      return task.state

    if taskResults.indexOf(true) >= 0
      @notify """
        "#{@tasks[taskResults.indexOf(true)].name}" is completed:+1: #{if message then "\n#{message}" else ''}
      """
      @removeListener('done', @checkAllTaskDone)
      @tasks.forEach (task) ->
        task.end()
      return true

    for result in taskResults
      if typeof(result) isnt 'boolean'
        return null

    @notify """
      "#{@tasks[taskResults.indexOf(false)].name}" is failed:disappointed: #{if message then "\n```#{message}```" else ''}
    """
    return false
