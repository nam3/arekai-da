{Robot} = require 'hubot'
{expect} = require 'chai'

describe 'check_atmos_stock', ->

  name = 'test-robot'
  robot = undefined
  regex = undefined
  url = 'http://www.atmos-tokyo.com/category/NEW/826737.html?utm_content=bufferf885f&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer'

  robot = new Robot null, 'mock-adapter', false, name
  require('../../../scripts/check_atmos_stock')(robot)
  regex = robot.listeners[0].regex

  context "with input = \"check atmos stock #{url}\"", ->

    it 'gets only url', ->

      match = regex.exec "#{name}: check atmos stock #{url}"
      expect match[1]
        .to.be.equal url

  context "with input = \"check atmos stock #{url} --time=5minutes\"", ->

    it 'gets url and time',  ->

      time = '5minutes'
      match = regex.exec "#{name}: check atmos stock #{url} --time=#{time}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal time
