{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_supreme', ->

  imgAlt = 'xxx'
  baseInput = "test-robot: dominator supreme \"#{imgAlt}\""
  from = '1986-12-02T00:00:00'
  category = 'accessories'
  size = 'Small'
  paymentMethod = 'cod'
  attempts = 3
  interval = 2000
  maxCheckoutDelay = 6000
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_supreme'

  context "with input = \"#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod}\"", ->

    it 'gets image alt, from, category, size, paymentMethod', ->

      match = regex.exec "#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal category
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal paymentMethod
      expect match[6]
        .to.be.equal undefined
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined
      expect match[9]
        .to.be.equal undefined

  context "with input = \"test-robot: dominator supreme \"xxx xxx\" --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod}\"", ->

    it 'gets image alt, from, category, size, paymentMethod', ->

      match = regex.exec "test-robot: dominator supreme \"xxx xxx\" --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod}"
      expect match[1]
      .to.be.equal 'xxx xxx'
      expect match[2]
      .to.be.equal from
      expect match[3]
      .to.be.equal category
      expect match[4]
      .to.be.equal size
      expect match[5]
      .to.be.equal paymentMethod
      expect match[6]
      .to.be.equal undefined
      expect match[7]
      .to.be.equal undefined
      expect match[8]
      .to.be.equal undefined
      expect match[9]
      .to.be.equal undefined


  context "with input = \"#{baseInput} --from=#{from} --category=t-shirts --size=#{size} --payment-method=#{paymentMethod}\"", ->

    it 'gets image alt, from, category, size, paymentMethod', ->

      match = regex.exec "#{baseInput} --from=#{from} --category=t-shirts --size=#{size} --payment-method=#{paymentMethod}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal 't-shirts'
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal paymentMethod
      expect match[6]
        .to.be.equal undefined
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined
      expect match[9]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --category=shoes --size=27.5 --payment-method=#{paymentMethod}\"", ->

    it 'gets image alt, from, category, size, paymentMethod', ->

      match = regex.exec "#{baseInput} --from=#{from} --category=shoes --size=27.5 --payment-method=#{paymentMethod}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal 'shoes'
      expect match[4]
        .to.be.equal '27.5'
      expect match[5]
        .to.be.equal paymentMethod
      expect match[6]
        .to.be.equal undefined
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined
      expect match[9]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets image alt, from, category, size, paymentMethod, attempts and interval', ->

      match = regex.exec "#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal category
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal paymentMethod
      expect Number(match[6])
        .to.be.equal attempts
      expect Number(match[7])
        .to.be.equal interval
      expect match[8]
        .to.be.equal undefined
      expect match[9]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --max-checkout-delay=#{maxCheckoutDelay}\"", ->

    it 'gets image alt, from, category, size, paymentMethod, attempts, interval and maxCheckoutDelay', ->

      match = regex.exec "#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --max-checkout-delay=#{maxCheckoutDelay}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal category
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal paymentMethod
      expect Number(match[6])
        .to.be.equal attempts
      expect Number(match[7])
        .to.be.equal interval
      expect Number match[8]
        .to.be.equal maxCheckoutDelay
      expect match[9]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --users=#{users}\"", ->

    it 'gets image alt, from, category, size, paymentMethod, attempts, interval and users', ->

      match = regex.exec "#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --users=#{users}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal category
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal paymentMethod
      expect Number(match[6])
        .to.be.equal attempts
      expect Number(match[7])
        .to.be.equal interval
      expect match[8]
        .to.be.equal undefined
      expect match[9]
        .to.be.equal users

  context "with input = \"#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --max-checkout-delay=#{maxCheckoutDelay} --users=#{users}\"", ->

    it 'gets image alt, from, category, size, paymentMethod, attempts, interval, maxCheckoutDelay and users', ->

      match = regex.exec "#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --max-checkout-delay=#{maxCheckoutDelay} --users=#{users}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal category
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal paymentMethod
      expect Number(match[6])
        .to.be.equal attempts
      expect Number(match[7])
        .to.be.equal interval
      expect Number match[8]
        .to.be.equal maxCheckoutDelay
      expect match[9]
        .to.be.equal users
