{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_supreme_with_nightmare', ->

  baseInput = "test-robot: dominator supreme"
  item1 = 'jackets:xxx'
  item2 = 'shoes:yyy'
  item3 = 'bags:include space'
  from = '1986-12-02T00:00:00'
  size = 'S'
  paymentMethod = 'credit-card'
  recaptchaTokenFetcherType = 'manual'
  attempts = 3
  interval = 2000
  maxCheckoutDelay = 6000
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_supreme_with_nightmare'

  context "with input = \"#{baseInput} --item1=\"#{item1}\" --from=#{from} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets image alt of item1, from, size, paymentMethod', ->

      match = regex.exec "#{baseInput} --item1=\"#{item1}\" --from=#{from} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal item1
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal undefined
      expect match[5]
        .to.be.equal from
      expect match[6]
        .to.be.equal size
      expect match[7]
        .to.be.equal paymentMethod
      expect match[8]
        .to.be.equal undefined
      expect Number match[9]
        .to.be.equal attempts
      expect Number match[10]
        .to.be.equal interval
      expect match[11]
        .to.be.equal undefined
      expect match[12]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --item1=\"#{item1}\" --item2=\"#{item2}\" --item3=\"#{item3}\" --from=#{from} --size=#{size} --payment-method=#{paymentMethod} --fetcher-type=#{recaptchaTokenFetcherType} --attempts=#{attempts} --interval=#{interval} --max-checkout-delay=#{maxCheckoutDelay} --users=#{users}\"", ->

    it 'gets image alt of item1, item2 and item3, from, paymentMethod, recaptchaTokenFetcherType, attempts, interval, maxCheckoutDelay and users', ->

      match = regex.exec "#{baseInput} --item1=\"#{item1}\" --item2=\"#{item2}\" --item3=\"#{item3}\" --from=#{from} --size=#{size} --payment-method=#{paymentMethod} --fetcher-type=#{recaptchaTokenFetcherType} --attempts=#{attempts} --interval=#{interval} --max-checkout-delay=#{maxCheckoutDelay} --users=#{users}"
      expect match[1]
        .to.be.equal item1
      expect match[2]
        .to.be.equal item2
      expect match[3]
        .to.be.equal item3
      expect match[4]
        .to.be.equal undefined
      expect match[5]
        .to.be.equal from
      expect match[6]
        .to.be.equal size
      expect match[7]
        .to.be.equal paymentMethod
      expect match[8]
        .to.be.equal recaptchaTokenFetcherType
      expect Number match[9]
        .to.be.equal attempts
      expect Number match[10]
        .to.be.equal interval
      expect Number match[11]
        .to.be.equal maxCheckoutDelay
      expect match[12]
        .to.be.equal users

  context "with input = \"#{baseInput} --item1=\"#{item1}\" --from=#{from} --size=9 --payment-method=#{paymentMethod} --users=#{users}\"", ->

    it 'gets image alt of item1, from, size, paymentMethod and users', ->

      match = regex.exec "#{baseInput} --item1=\"#{item1}\" --from=#{from} --size=9 --payment-method=#{paymentMethod} --users=#{users}"
      expect match[1]
        .to.be.equal item1
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal undefined
      expect match[5]
        .to.be.equal from
      expect match[6]
        .to.be.equal '9'
      expect match[7]
        .to.be.equal paymentMethod
      expect match[8]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined
      expect match[10]
        .to.be.equal undefined
      expect match[11]
        .to.be.equal undefined
      expect match[12]
        .to.be.equal users

  context "with input = \"#{baseInput} --item1=\"#{item1}\" --from=#{from} --size=#{size} --payment-method=#{paymentMethod} --max-checkout-delay=#{maxCheckoutDelay} --users=#{users}\"", ->

    it 'gets image alt of item1, from, size, paymentMethod, maxCheckoutDelay and users', ->

      match = regex.exec "#{baseInput} --item1=\"#{item1}\" --from=#{from} --size=#{size} --payment-method=#{paymentMethod} --max-checkout-delay=#{maxCheckoutDelay} --users=#{users}"
      expect match[1]
        .to.be.equal item1
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal undefined
      expect match[5]
        .to.be.equal from
      expect match[6]
        .to.be.equal size
      expect match[7]
        .to.be.equal paymentMethod
      expect match[8]
        .to.be.equal undefined
      expect match[9]
        .to.be.equal undefined
      expect match[10]
        .to.be.equal undefined
      expect Number match[11]
        .to.be.equal maxCheckoutDelay
      expect match[12]
        .to.be.equal users
