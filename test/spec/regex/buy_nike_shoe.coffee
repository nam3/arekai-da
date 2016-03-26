{expect} = require 'chai'

Helper = require '../../helper'

describe 'buy_nike_shoe', ->

  url = 'http://store.nike.com/jp/ja_jp/pd/%E3%82%A8%E3%82%A2-%E3%82%B8%E3%83%A7%E3%83%BC%E3%83%80%E3%83%B3-4-%E3%83%AC%E3%83%88%E3%83%AD-%E3%83%97%E3%83%AA%E3%82%B9%E3%82%AF%E3%83%BC%E3%83%AB%EF%BC%86%E3%83%9C%E3%83%BC%E3%82%A4%E3%82%BA%E3%82%B7%E3%83%A5%E3%83%BC%E3%82%BA/pid-10363592/pgid-11233409'
  baseInput = "test-robot: buy nike shoe #{url}"
  size = '28'
  purchaseFlag = 'true'
  from = '1986-12-02T00:00:00'
  interval = '2'
  times = '8'
  concurrency = '4'

  regex = Helper.importDispatcherRegex require '../../../scripts/buy_nike_shoe'

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
        .to.be.undefined
      expect match[4]
        .to.be.equal from

  context "with input = \"#{baseInput} --purchase=#{purchaseFlag} --from=#{from}\"", ->

    it 'gets url and purchase flag',  ->

      match = regex.exec "#{baseInput} --purchase=#{purchaseFlag} --from=#{from}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.undefined
      expect match[3]
        .to.be.equal purchaseFlag
      expect match[4]
        .to.be.equal from

  context "with input = \"#{baseInput} --size=#{size} --from=#{from}\"", ->

    it 'gets url, size and from', ->

      match = regex.exec "#{baseInput} --size=#{size} --from=#{from}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.undefined
      expect match[4]
        .to.be.equal from

  context "with input = \"#{baseInput} --size=#{size} --from=#{from} --interval=#{interval} --times=#{times}\"", ->

    it 'gets url, size, from, interval and times', ->

      match = regex.exec "#{baseInput} --size=#{size} --from=#{from} --interval=#{interval} --times=#{times}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.undefined
      expect match[4]
        .to.be.equal from
      expect match[5]
        .to.be.equal interval
      expect match[6]
        .to.be.equal times

  context "with input = \"#{baseInput} --size=#{size} --from=#{from} --interval=#{interval} --times=#{times} --concurrency=#{concurrency}\"", ->

    it 'gets url, size, from, interval, times and concurrency', ->

      match = regex.exec "#{baseInput} --size=#{size} --from=#{from} --interval=#{interval} --times=#{times} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.undefined
      expect match[4]
        .to.be.equal from
      expect match[5]
        .to.be.equal interval
      expect match[6]
        .to.be.equal times
      expect match[7]
        .to.be.equal concurrency

  context "with input = \"#{baseInput} --from=#{from} --concurrency=#{concurrency}\"", ->

    it 'gets url, from and concurrency', ->

      match = regex.exec "#{baseInput} --from=#{from} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.undefined
      expect match[3]
        .to.be.undefined
      expect match[4]
        .to.be.equal from
      expect match[5]
        .to.be.undefined
      expect match[6]
        .to.be.undefined
      expect match[7]
        .to.be.equal concurrency
