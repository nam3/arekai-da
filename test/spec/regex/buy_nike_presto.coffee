{Robot} = require 'hubot'
{expect} = require 'chai'

describe 'buy_nike_presto', ->

  name = 'test-robot'
  robot = undefined
  regex = undefined
  url = 'http://store.nike.com/jp/ja_jp/pd/%E3%83%8A%E3%82%A4%E3%82%AD-%E3%82%A8%E3%82%A2-%E3%83%97%E3%83%AC%E3%82%B9%E3%83%88-%E3%83%A1%E3%83%B3%E3%82%BA%E3%82%B7%E3%83%A5%E3%83%BC%E3%82%BA/pid-10363155/pgid-11191366'
  size = 'M'
  time = '00 00 09 * * *'
  baseInput = "#{name}: buy nike presto #{url}"

  robot = new Robot null, 'mock-adapter', false, name
  require('../../../scripts/buy_nike_presto')(robot)
  regex = robot.listeners[0].regex

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal url

  context "with input = \"#{baseInput} --size=#{size}\"", ->

    it 'gets url and size', ->

      match = regex.exec "#{baseInput} --size=#{size}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size

  context "with input = \"#{baseInput} --time=#{time}\"", ->

    it 'gets url and time',  ->

      match = regex.exec "#{baseInput} --time=#{time}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal time

  context "with input = \"#{baseInput} --size=#{size} --time=#{time}\"", ->

    it 'gets url, size and time', ->

      match = regex.exec "#{baseInput} --size=#{size} --time=#{time}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal time
