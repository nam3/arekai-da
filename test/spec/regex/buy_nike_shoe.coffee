{Robot} = require 'hubot'
{expect} = require 'chai'

describe 'buy_nike_shoe', ->

  name = 'test-robot'
  robot = undefined
  regex = undefined
  url = 'http://store.nike.com/jp/ja_jp/pd/%E3%82%A8%E3%82%A2-%E3%82%B8%E3%83%A7%E3%83%BC%E3%83%80%E3%83%B3-4-%E3%83%AC%E3%83%88%E3%83%AD-%E3%83%97%E3%83%AA%E3%82%B9%E3%82%AF%E3%83%BC%E3%83%AB%EF%BC%86%E3%83%9C%E3%83%BC%E3%82%A4%E3%82%BA%E3%82%B7%E3%83%A5%E3%83%BC%E3%82%BA/pid-10363592/pgid-11233409'
  size = '28'
  time = '00 00 09 * * *'

  robot = new Robot null, 'mock-adapter', false, name
  require('../../../scripts/buy_nike_shoe')(robot)
  regex = robot.listeners[0].regex

  context "with input = \"buy nike shoe #{url}\"", ->

    it 'gets only url', ->

      match = regex.exec "#{name}: buy nike shoe #{url}"
      expect match[1]
        .to.be.equal url

  context "with input = \"buy nike shoe #{url} --size=#{size}\"", ->

    it 'gets url and size', ->

      match = regex.exec "#{name}: buy nike shoe #{url} --size=#{size}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size

  context "with input = \"buy nike shoe #{url} --time=#{time}\"", ->

    it 'gets url and time',  ->

      match = regex.exec "#{name}: buy nike shoe #{url} --time=#{time}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal time

  context "with input = \"buy nike shoe #{url} --size=#{size} --time=#{time}\"", ->

    it 'gets url, size and time', ->

      match = regex.exec "#{name}: buy nike shoe #{url} --size=#{size} --time=#{time}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal time
