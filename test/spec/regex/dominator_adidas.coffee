{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_adidas', ->

  url = 'http://shop.adidas.jp/pc/item/detail.cgi?brand_code=110&itemCd=110_S75074&itemGrcd=110_GWD46&itemDir1=16SS'
  baseInput = "test-robot: dominator adidas #{url}"
  size = '27.0'
  from = '1986-12-02T00:00:00'
  interval = '1'
  times = '1'
  concurrency = '2'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_adidas'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal url

  context "with input = \"#{baseInput} --size=#{size} --from=#{from} --interval=#{interval} --times=#{times}\"", ->

    it 'gets item url, from, interval and times', ->

      match = regex.exec "#{baseInput} --size=#{size} --from=#{from} --interval=#{interval} --times=#{times}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal from
      expect match[4]
        .to.be.equal interval
      expect match[5]
        .to.be.equal times
      expect match[6]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --size=#{size} --from=#{from} --interval=#{interval} --times=#{times} --concurrency=#{concurrency}\"", ->

    it 'gets image alt, from, interval and times', ->

      match = regex.exec "#{baseInput} --size=#{size} --from=#{from} --interval=#{interval} --times=#{times} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal from
      expect match[4]
        .to.be.equal interval
      expect match[5]
        .to.be.equal times
      expect match[6]
        .to.be.equal concurrency
