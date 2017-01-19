{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_atmos', ->

  url = 'http://www.atmos-tokyo.com/category/SHOES/725066_006.html'
  baseInput = "test-robot: dominator atmos #{url}"
  from = '1986-12-02T00:00:00'
  type = '270CM'
  paymentMethod = 'credit-card'
  attempts = '16'
  interval = '1000'
  concurrency = '2'
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_atmos'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal url

  context "with input = \"#{baseInput} --from=#{from} --type=#{type} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets item url, from, type, attempts and interval', ->

      match = regex.exec "#{baseInput} --from=#{from} --type=#{type} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal type
      expect match[4]
        .to.be.equal undefined
      expect match[5]
        .to.be.equal attempts
      expect match[6]
        .to.be.equal interval
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --type=#{type} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}\"", ->

    it 'gets item url, from, type, attempts, interval and concurrency', ->

      match = regex.exec "#{baseInput} --from=#{from} --type=#{type} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal type
      expect match[4]
        .to.be.equal undefined
      expect match[5]
        .to.be.equal attempts
      expect match[6]
        .to.be.equal interval
      expect match[7]
        .to.be.equal concurrency
      expect match[8]
        .to.be.equal undefined

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
