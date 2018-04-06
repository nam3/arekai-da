{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_snkrs', ->
  productId = 'AJ7291-002'
  size = '10'
  baseInput = "test-robot: dominator snkrs #{productId}"
  from = '1986-12-02T00:00:00'
  attempts = '16'
  interval = '1000'
  concurrency = '2'
  users = 'user001,user002,user_003'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_snkrs'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only productId', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal productId

  context "with input = \"#{baseInput} --from=#{from} --size=#{size} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets item productId, from, size, attempts and interval', ->

      match = regex.exec "#{baseInput} --from=#{from} --size=#{size} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal productId
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal size
      expect match[4]
        .to.be.equal attempts
      expect match[5]
        .to.be.equal interval
      expect match[6]
        .to.be.equal undefined
      expect match[7]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --size=#{size} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}\"", ->

    it 'gets item productId, from, size, attempts, interval and concurrency', ->

      match = regex.exec "#{baseInput} --from=#{from} --size=#{size} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal productId
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal size
      expect match[4]
        .to.be.equal attempts
      expect match[5]
        .to.be.equal interval
      expect match[6]
        .to.be.equal concurrency
      expect match[7]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --size=#{size} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency} --users=#{users}\"", ->

    it 'gets item productId, size, from, attempts, interval, concurrency and users', ->

      match = regex.exec "#{baseInput} --from=#{from} --size=#{size} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency} --users=#{users}"
      expect match[1]
        .to.be.equal productId
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal size
      expect match[4]
        .to.be.equal attempts
      expect match[5]
        .to.be.equal interval
      expect match[6]
        .to.be.equal concurrency
      expect match[7]
        .to.be.equal users
