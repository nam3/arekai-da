{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_fujiya', ->

  url = 'http://cjmart.jp/products/detail.php?product_id=2627'
  productId = '266'
  productClassId = '13484'
  baseInput = "test-robot: dominator fujiya #{productId} #{productClassId}"
  from = '1986-12-02T00:00:00'
  interval = '1'
  times = '20'
  concurrency = '3'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_fujiya'

  context "with input = \"#{baseInput}\"", ->

    it 'gets product id and product class id', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal productId
      expect match[2]
        .to.be.equal productClassId

  context "with input = \"#{baseInput} --from=#{from} --interval=#{interval} --times=#{times}\"", ->

    it 'gets product id, product class id, from, interval and times', ->

      match = regex.exec "#{baseInput} --from=#{from} --interval=#{interval} --times=#{times}"
      expect match[1]
        .to.be.equal productId
      expect match[2]
        .to.be.equal productClassId
      expect match[3]
        .to.be.equal from
      expect match[4]
        .to.be.equal interval
      expect match[5]
        .to.be.equal times
      expect match[6]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --interval=#{interval} --times=#{times} --concurrency=#{concurrency}\"", ->

    it 'gets product id, product class id, from, interval, times and concurrency', ->

      match = regex.exec "#{baseInput} --from=#{from} --interval=#{interval} --times=#{times} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal productId
      expect match[2]
        .to.be.equal productClassId
      expect match[3]
        .to.be.equal from
      expect match[4]
        .to.be.equal interval
      expect match[5]
        .to.be.equal times
      expect match[6]
        .to.be.equal concurrency
