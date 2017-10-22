{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_supreme_with_nightmare', ->

  baseInput = "test-robot: dominator supreme-browser"
  itemId = '123456'
  category = 'jackets'
  from = '1986-12-02T00:00:00'
  size = 'Small'
  paymentMethod = 'credit-card'
  attempts = 3
  interval = 2000
  maxCheckoutDelay = 6000
  recaptchaFetcherType = 'manual'
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_supreme_with_browser'

  context "with input = \"#{baseInput} #{itemId} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets image alt of item1, from, size, paymentMethod', ->

      match = regex.exec "#{baseInput} #{itemId} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal itemId
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal category
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal paymentMethod
      expect Number match[6]
        .to.be.equal attempts
      expect Number match[7]
        .to.be.equal interval
      expect match[8]
        .to.be.equal undefined
      expect match[9]
        .to.be.equal undefined
      expect match[10]
        .to.be.equal undefined

  context "with input = \"#{baseInput} #{itemId} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --max-checkout-delay=#{maxCheckoutDelay} --fetcher-mode=#{recaptchaFetcherType}\"", ->

    it 'gets image alt of item1, from, size, paymentMethod', ->

      match = regex.exec "#{baseInput} #{itemId} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --max-checkout-delay=#{maxCheckoutDelay} --fetcher-mode=#{recaptchaFetcherType}"
      expect match[1]
        .to.be.equal itemId
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal category
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal paymentMethod
      expect Number match[6]
        .to.be.equal attempts
      expect Number match[7]
        .to.be.equal interval
      expect Number match[8]
        .to.be.equal maxCheckoutDelay
      expect match[9]
        .to.be.equal recaptchaFetcherType
      expect match[10]
        .to.be.equal undefined

  context "with input = \"#{baseInput} #{itemId} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --max-checkout-delay=#{maxCheckoutDelay} --fetcher-mode=#{recaptchaFetcherType} --users=#{users}\"", ->

    it 'gets image alt of item1, from, size, paymentMethod', ->

      match = regex.exec "#{baseInput} #{itemId} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --max-checkout-delay=#{maxCheckoutDelay} --fetcher-mode=#{recaptchaFetcherType} --users=#{users}"
      expect match[1]
        .to.be.equal itemId
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal category
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal paymentMethod
      expect Number match[6]
        .to.be.equal attempts
      expect Number match[7]
        .to.be.equal interval
      expect Number match[8]
        .to.be.equal maxCheckoutDelay
      expect match[9]
        .to.be.equal recaptchaFetcherType
      expect match[10]
        .to.be.equal users
