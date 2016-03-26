{expect} = require 'chai'

Helper = require '../../helper'

describe 'buy_nike_shoe', ->

  imgAlt = 'Ah-0sjsjorc'
  baseInput = "test-robot: buy supreme new #{imgAlt}"
  size = 'l'
  creditCardFlag = 'false'
  time = '00 00 11 * * *'
  regex = Helper.importDispatcherRegex require '../../../scripts/buy_supreme_new'

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
        .to.be.equal creditCardFlag
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
