{Robot} = require 'hubot'
{expect} = require 'chai'

describe 'buy_apple_special', ->

  name = 'test-robot'
  robot = undefined
  regex = undefined
  url = 'http://www.apple.com/jp/shop/product/FE182J/A/airmac-time-capsule-%E6%95%B4%E5%82%99%E6%B8%88%E8%A3%BD%E5%93%81-3tb'

  robot = new Robot null, 'mock-adapter', false, name
  require('../../../scripts/buy_apple_special')(robot)
  regex = robot.listeners[0].regex

  context "with input = \"buy apple special #{url}\"", ->

    it 'gets only url', ->

      match = regex.exec "#{name}: buy apple special #{url}"
      expect match[1]
        .to.be.equal url

  context "with input = \"buy apple special #{url} --time=00 00 09 * * *\"", ->

    it 'gets url and time',  ->

      time = '00 00 09 * * *'
      match = regex.exec "#{name}: buy apple special #{url} --time=#{time}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal time
