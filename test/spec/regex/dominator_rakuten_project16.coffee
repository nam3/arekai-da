{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_rakuten_project16', ->

  url = 'http://item.rakuten.co.jp/project1-6/9784197104574/'
  baseInput = "test-robot: dominator rakuten-project16 #{url}"
  from = '1986-12-02T00:00:00'
  paymentMethod = 'seven-eleven'
  attempts = '1'
  interval = '1000'
  concurrency = '2'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_rakuten_project16'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal url

  context "with input = \"#{baseInput} --from=#{from} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets item url, from, payment method, attempts and interval', ->

      match = regex.exec "#{baseInput} --from=#{from} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal paymentMethod
      expect match[4]
        .to.be.equal attempts
      expect match[5]
        .to.be.equal interval
      expect match[6]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}\"", ->

    it 'gets item url, from, payment method, attempts, interval and concurrency', ->

      match = regex.exec "#{baseInput} --from=#{from} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal paymentMethod
      expect match[4]
        .to.be.equal attempts
      expect match[5]
        .to.be.equal interval
      expect match[6]
        .to.be.equal concurrency

  context "when chooses invalid payment method", ->

    it 'does not match to regex', ->

      match = regex.exec "#{baseInput} --from=#{from} --payment-method=dummy --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}"
      expect match
        .to.be.null
