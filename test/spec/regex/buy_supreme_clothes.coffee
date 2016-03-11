{expect} = require 'chai'

Helper = require '../../helper'

describe 'buy_nike_shoe', ->

  url = 'http://www.supremenewyork.com/shop/jackets/car-coat/snakeskin'
  baseInput = "test-robot: buy supreme clothes #{url}"
  size = 'm'
  time = '00 00 11 * * *'
  regex = Helper.importDispatcherRegex require('../../../scripts/buy_supreme_clothes')

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --size=#{size}\"", ->

    it 'gets url and time',  ->

      match = regex.exec "#{baseInput} --size=#{size}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal undefined

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

    it 'gets url and time',  ->

      match = regex.exec "#{baseInput} --size=#{size} --time=#{time}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal time
