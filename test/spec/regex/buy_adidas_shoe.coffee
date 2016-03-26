{expect} = require 'chai'

Helper = require '../../helper'

describe 'buy_adidas_shoe', ->

  url = 'http://shop.adidas.jp/pc/item/detail.cgi?brand_code=110&itemCd=110_S79150&itemGrcd=110_KAA48&itemDir1=16SS'
  baseInput = "test-robot: buy adidas shoe #{url}"
  size = '27.0'
  from = '1986-12-02T00:00:00'
  interval = '2'
  times = '8'
  concurrency = '4'

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

  context "with input = \"#{baseInput} --from=#{from}\"", ->

    it 'gets url and from',  ->

      match = regex.exec "#{baseInput} --from=#{from}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.undefined
      expect match[3]
        .to.be.equal from

  context "with input = \"#{baseInput} --from=#{from}\"", ->

    it 'gets url and from',  ->

      match = regex.exec "#{baseInput} --from=#{from}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.undefined
      expect match[3]
        .to.be.equal from

  context "with input = \"#{baseInput} --size=#{size} --from=#{from}\"", ->

    it 'gets url, size and from', ->

      match = regex.exec "#{baseInput} --size=#{size} --from=#{from}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal from

  context "with input = \"#{baseInput} --size=#{size} --from=#{from} --interval=#{interval} --times=#{times}\"", ->

    it 'gets url, size, from, interval and times', ->

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

  context "with input = \"#{baseInput} --size=#{size} --from=#{from} --interval=#{interval} --times=#{times} --concurrency=#{concurrency}\"", ->

    it 'gets url, size, from, interval, times and concurrency', ->

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

  context "with input = \"#{baseInput} --from=#{from} --concurrency=#{concurrency}\"", ->

    it 'gets url, from and concurrency', ->

      match = regex.exec "#{baseInput} --from=#{from} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.undefined
      expect match[3]
        .to.be.equal from
      expect match[4]
        .to.be.undefined
      expect match[5]
        .to.be.undefined
      expect match[6]
        .to.be.equal concurrency
