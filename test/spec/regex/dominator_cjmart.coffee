{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_cjmart', ->

  url = 'http://cjmart.jp/products/detail.php?product_id=2627'
  baseInput = "test-robot: dominator cjmart #{url}"
  from = '1986-12-02T00:00:00'
  interval = '1'
  times = '20'
  concurrency = '3'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_cjmart'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal url

  context "with input = \"#{baseInput} --from=#{from} --interval=#{interval} --times=#{times}\"", ->

    it 'gets image alt, from, interval and times', ->

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

    it 'gets image alt, from, interval and times', ->

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
