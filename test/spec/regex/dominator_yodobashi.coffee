{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_yodobashi', ->

  url = 'http://www.yodobashi.com/MEDICOM-TOY-MANUAL-VOLUME-%EF%BC%88%E3%83%A1%E3%83%87%E3%82%A3%E3%82%B3%E3%83%A0-%E3%83%88%E3%82%A4-%E3%83%9E%E3%83%8B%E3%83%A5%E3%82%A2%E3%83%AB%EF%BC%883%EF%BC%89%EF%BC%89%EF%BC%9A-%E3%82%BF%E3%82%A6%E3%83%B3%E3%83%A0%E3%83%83%E3%82%AF-%E5%8D%98%E8%A1%8C%E6%9C%AC/pd/100000009002599577/'
  baseInput = "test-robot: dominator yodobashi #{url}"
  from = '1986-12-02T00:00:00'
  interval = '1'
  times = '20'
  concurrency = '3'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_yodobashi'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal url

  context "with input = \"#{baseInput} --from=#{from}\"", ->

    it 'gets url, from', ->

      match = regex.exec "#{baseInput} --from=#{from}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal undefined
      expect match[5]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --interval=#{interval} --times=#{times}\"", ->

    it 'gets url, from, interval and times', ->

      match = regex.exec "#{baseInput} --from=#{from} --interval=#{interval} --times=#{times}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal interval
      expect match[4]
        .to.be.equal times
      expect match[5]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --interval=#{interval} --times=#{times} --concurrency=#{concurrency}\"", ->

    it 'gets url, from, interval and times', ->

      match = regex.exec "#{baseInput} --from=#{from} --interval=#{interval} --times=#{times} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal interval
      expect match[4]
        .to.be.equal times
      expect match[5]
        .to.be.equal concurrency
