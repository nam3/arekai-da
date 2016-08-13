{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_rakuten_mita_sneakers', ->

  url = 'http://item.rakuten.co.jp/mitasneakers/mi160504-08/'
  baseInput = "test-robot: dominator rakuten-mita-sneakers #{url}"
  size = '27.0'
  from = '1986-12-02T00:00:00'
  attempts = '16'
  interval = '1000'
  concurrency = '2'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_rakuten_mita_sneakers'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal url

  context "with input = \"#{baseInput} --size=#{size} --from=#{from} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets item url, size, from, attempts and interval', ->

      match = regex.exec "#{baseInput} --size=#{size} --from=#{from} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal from
      expect match[4]
        .to.be.equal attempts
      expect match[5]
        .to.be.equal interval
      expect match[6]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --size=#{size} --from=#{from} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}\"", ->

    it 'gets item url, size, from, attempts, interval and concurrency', ->

      match = regex.exec "#{baseInput} --size=#{size} --from=#{from} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal from
      expect match[4]
        .to.be.equal attempts
      expect match[5]
        .to.be.equal interval
      expect match[6]
        .to.be.equal concurrency
