{expect} = require 'chai'

Helper = require '../../helper'

describe 'buy_adidas_shoe', ->

  url = 'http://shop.adidas.jp/pc/item/detail.cgi?brand_code=110&itemCd=110_AQ4651&itemGrcd=110_JPT15&itemDir1=16SS'
  baseInput = "test-robot: buy adidas shoe #{url}"
  size = '28.0'
  time = '00 00 00 * * *'
  regex = Helper.importDispatcherRegex require '../../../scripts/buy_adidas_shoe'

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
