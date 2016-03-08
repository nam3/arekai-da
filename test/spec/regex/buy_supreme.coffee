{Robot} = require 'hubot'
{expect} = require 'chai'

describe 'buy_nike_shoe', ->

  name = 'test-robot'
  robot = undefined
  regex = undefined
  url = 'http://www.supremenewyork.com/shop/accessories/keychain-pen/stainless-steel'

  robot = new Robot null, 'mock-adapter', false, name
  require('../../../scripts/buy_supreme')(robot)
  regex = robot.listeners[0].regex

  context "with input = \"buy supreme #{url}\"", ->

    it 'gets only url', ->

      match = regex.exec "#{name}: buy supreme #{url}"
      expect match[1]
        .to.be.equal url

  context "with input = \"buy supreme #{url} --time=00 00 11 * * *\"", ->

    it 'gets url and time',  ->

      time = '00 00 11 * * *'
      match = regex.exec "#{name}: buy supreme #{url} --time=#{time}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal time
