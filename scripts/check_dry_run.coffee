# Description
#   Check dry run option
#
# Configuration:
#   HUBOT_DRY_RUN
#
# Author:
#   JumpeiArashi

utils = require './utils/hubot'

module.exports = (robot) ->

  robot.hear /.*/, (res) ->
    if utils.isDryrun()
      res.send 'I\'m running dry run mode. So, I do nothing＼(^o^)／'
