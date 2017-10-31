{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_supreme_launch', ->

  baseInput = "test-robot: dominator supreme-launch "
  from = '1986-12-02T00:00:00'
  category = 'accessories'
  size = 'Small'
  paymentMethod = 'cod'
  attempts = 3
  interval = 2000
  fetcherMode = 'manual'
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_supreme_launch'

  context "with input = \"#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod}\"", ->
    it 'gets image alt, from, category, size, paymentMethod', ->
      match = regex.exec "#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod}"
      expect match[1]
        .to.be.equal from
      expect match[2]
        .to.be.equal category
      expect match[3]
        .to.be.equal size
      expect match[4]
        .to.be.equal paymentMethod
      expect match[5]
        .to.be.equal undefined
      expect match[6]
        .to.be.equal undefined
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --fetcher-mode=#{fetcherMode} --users=#{users}\"", ->
    it 'gets image alt, from, category, size, paymentMethod', ->
      match = regex.exec "#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --fetcher-mode=#{fetcherMode} --users=#{users}"
      expect match[1]
        .to.be.equal from
      expect match[2]
        .to.be.equal category
      expect match[3]
        .to.be.equal size
      expect match[4]
        .to.be.equal paymentMethod
      expect Number(match[5])
        .to.be.equal attempts
      expect Number(match[6])
        .to.be.equal interval
      expect match[7]
        .to.be.equal fetcherMode
      expect match[8]
        .to.be.equal users
