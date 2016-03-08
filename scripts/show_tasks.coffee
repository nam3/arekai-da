# Description
#   Describe current tasks
#
# Commands:
#   arekai-da: show tasks
#
# Author:
#   JumpeiArashi

{describeTasks} = require './services/task'

module.exports = (robot) ->

  robot.respond /show\s+tasks\s*$/, (res) ->

    tasks = describeTasks()

    if tasks.length
      describedTasks = (
        """
        ```
        id: #{task.id}
        name: #{task.name}
        crontime: #{task.crontime}
        ```
        """ for task in tasks
      )
      res.send "See following tasks #{describedTasks}"

    else
      res.send 'I have no task...'
