{Robot} = require 'hubot'

module.exports = (dispatcher, name = 'test-robot') ->

  robot = new Robot null, 'mock-adapter', false, name
  dispatcher(robot)
  return robot.listeners[0].regex
