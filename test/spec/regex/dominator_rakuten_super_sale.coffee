{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_super_sale', ->

  url = 'http://item.rakuten.co.jp/excellar/1300002418/'
  baseInput = "test-robot: dominator rakuten-super-sale #{url}"
  from = '1986-12-02T00:00:00'
  type = 'testType'
  paymentMethod = 'transfer'
  attempts = '16'
  interval = '10'
  concurrency = '1'
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_rakuten_super_sale'

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
        .to.be.equal undefined
      expect match[4]
        .to.be.equal paymentMethod
      expect match[5]
        .to.be.equal attempts
      expect match[6]
        .to.be.equal interval
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}\"", ->

    it 'gets item url, from, payment method, attempts, interval and concurrency', ->

      match = regex.exec "#{baseInput} --from=#{from} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal paymentMethod
      expect match[5]
        .to.be.equal attempts
      expect match[6]
        .to.be.equal interval
      expect match[7]
        .to.be.equal concurrency
      expect match[8]
        .to.be.equal undefined

  context "when chooses invalid payment method", ->

    it 'does not match to regex', ->

      match = regex.exec "#{baseInput} --from=#{from} --payment-method=dummy --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}"
      expect match
        .to.be.null

  context "with input = \"#{baseInput} --from=#{from} --type=#{type} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets item url, from, type, payment method, attempts and interval', ->

      match = regex.exec "#{baseInput} --from=#{from} --type=#{type} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal type
      expect match[4]
        .to.be.equal paymentMethod
      expect match[5]
        .to.be.equal attempts
      expect match[6]
        .to.be.equal interval
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --type=#{type} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --users=#{users}\"", ->

    it 'gets item url, from, type, payment method, attempts, interval and users', ->

      match = regex.exec "#{baseInput} --from=#{from} --type=#{type} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --users=#{users}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal type
      expect match[4]
        .to.be.equal paymentMethod
      expect match[5]
        .to.be.equal attempts
      expect match[6]
        .to.be.equal interval
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal users

  context "with input = \"#{baseInput} --from=#{from} --type=#{type} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}\"", ->

    it 'gets item url, from, type, payment method, attempts, interval and concurrency', ->

      match = regex.exec "#{baseInput} --from=#{from} --type=#{type} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal type
      expect match[4]
        .to.be.equal paymentMethod
      expect match[5]
        .to.be.equal attempts
      expect match[6]
        .to.be.equal interval
      expect match[7]
        .to.be.equal concurrency
      expect match[8]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --type=#{type} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency} --users=#{users}\"", ->

    it 'gets item url, from, type, payment method, attempts, interval, concurrency and users', ->

      match = regex.exec "#{baseInput} --from=#{from} --type=#{type} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency} --users=#{users}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal type
      expect match[4]
        .to.be.equal paymentMethod
      expect match[5]
        .to.be.equal attempts
      expect match[6]
        .to.be.equal interval
      expect match[7]
        .to.be.equal concurrency
      expect match[8]
        .to.be.equal users
