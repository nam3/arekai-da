{expect} = require 'chai'

Helper = require '../../helper'

describe 'buy_sea_bag', ->

  baseInput = "test-robot: buy sea bag"
  from = '1986-12-02T00:00:00'
  interval = '2'
  times = '8'
  concurrency = '4'

  regex = Helper.importDispatcherRegex require '../../../scripts/buy_sea_bag'

  context "with input = \"#{baseInput} --from=#{from}\"", ->

    it 'from',  ->

      match = regex.exec "#{baseInput} --from=#{from}"
      expect match[1]
        .to.be.equal from

  context "with input = \"#{baseInput} --from=#{from} --interval=#{interval} --times=#{times}\"", ->

    it 'gets from, interval and times', ->

      match = regex.exec "#{baseInput} --from=#{from} --interval=#{interval} --times=#{times}"
      expect match[1]
        .to.be.equal from
      expect match[2]
        .to.be.equal interval
      expect match[3]
        .to.be.equal times

  context "with input = \"#{baseInput} --from=#{from} --interval=#{interval} --times=#{times} --concurrency=#{concurrency}\"", ->

    it 'gets url, size, from, interval, times and concurrency', ->

      match = regex.exec "#{baseInput} --from=#{from} --interval=#{interval} --times=#{times} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal from
      expect match[2]
        .to.be.equal interval
      expect match[3]
        .to.be.equal times
      expect match[4]
        .to.be.equal concurrency
