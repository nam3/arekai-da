{Robot} = require 'hubot'
{expect} = require 'chai'

describe 'buy_nike_shoe', ->

  name = 'test-robot'
  robot = undefined
  regex = undefined
  imgAlt = 'Ah-0sjsjorc'
  baseInput = "#{name}: buy supreme new #{imgAlt}"
  size = 'l'
  creditCardFlag = 'true'
  time = '00 00 11 * * *'

  robot = new Robot null, 'mock-adapter', false, name
  require('../../../scripts/buy_supreme_new')(robot)
  regex = robot.listeners[0].regex

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal imgAlt

  context "with input = \"#{baseInput} --size=#{size}\"", ->

    it 'gets url and time',  ->

      match = regex.exec "#{baseInput} --size=#{size}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --credit-card=#{creditCardFlag}\"", ->

    it 'gets url and time',  ->

      match = regex.exec "#{baseInput} --credit-card=#{creditCardFlag}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal 'true'
      expect match[4]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --time=#{time}\"", ->

    it 'gets url and time',  ->

      match = regex.exec "#{baseInput} --time=#{time}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal time

  context "with input = \"#{baseInput} --size=#{size} --time=#{time}\"", ->

    it 'gets url and time',  ->

      match = regex.exec "#{baseInput} --size=#{size} --time=#{time}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal time

  context "with input = \"#{baseInput} --credit-card=#{creditCardFlag} --time=#{time}\"", ->

    it 'gets url and time',  ->

      match = regex.exec "#{baseInput} --credit-card=#{creditCardFlag} --time=#{time}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal creditCardFlag
      expect match[4]
        .to.be.equal time

  context "with input = \"#{baseInput} --size=#{size} --credit-card=#{creditCardFlag} --time=#{time}\"", ->

    it 'gets url and time',  ->

      match = regex.exec "#{baseInput} --size=#{size} --credit-card=#{creditCardFlag} --time=#{time}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal creditCardFlag
      expect match[4]
        .to.be.equal time
