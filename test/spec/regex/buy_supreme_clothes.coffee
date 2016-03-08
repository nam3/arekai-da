{Robot} = require 'hubot'
{expect} = require 'chai'

describe 'buy_nike_shoe', ->

  name = 'test-robot'
  robot = undefined
  regex = undefined
  url = 'http://www.supremenewyork.com/shop/jackets/car-coat/snakeskin'
  size = 'm'
  time = '00 00 11 * * *'

  robot = new Robot null, 'mock-adapter', false, name
  require('../../../scripts/buy_supreme_clothes')(robot)
  regex = robot.listeners[0].regex

  context "with input = \"buy supreme clothes #{url}\"", ->

    it 'gets only url', ->

      match = regex.exec "#{name}: buy supreme clothes #{url}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal undefined

  context "with input = \"buy supreme clothes #{url} --size=#{size}\"", ->

    it 'gets url and time',  ->

      match = regex.exec "#{name}: buy supreme clothes #{url} --size=#{size}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal undefined

  context "with input = \"buy supreme clothes #{url} --time=#{time}\"", ->

    it 'gets url and time',  ->

      match = regex.exec "#{name}: buy supreme clothes #{url} --time=#{time}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal time

  context "with input = \"buy supreme clothes #{url} --size=#{size} --time=#{time}\"", ->

    it 'gets url and time',  ->

      match = regex.exec "#{name}: buy supreme clothes #{url} --size=#{size} --time=#{time}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal time
