{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_abc_mart', ->

  itemId = '5564360022025'
  baseInput = "test-robot: dominator abc-mart --item-id=#{itemId}"
  from = '1986-12-02T00:00:00'
  size = '27.0'
  concurrency = 1
  attempts = 16
  interval = 1000
  jobConcurrency = 2
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_abc_mart'

  context "with input = \"#{baseInput}\"", ->
    it 'gets only item id', ->
      match = regex.exec baseInput
      expect match[1]
        .to.be.equal itemId

  context "with input = \"#{baseInput} --from=#{from} --size=#{size} --concurrency=#{concurrency} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets item id, from, size, concurrency, attempts and interval', ->

      match = regex.exec "#{baseInput} --from=#{from} --size=#{size} --concurrency=#{concurrency} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal itemId
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal size
      expect Number(match[4])
        .to.be.equal concurrency
      expect Number(match[5])
        .to.be.equal attempts
      expect Number(match[6])
        .to.be.equal interval
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --size=#{size} --concurrency=#{concurrency} --attempts=#{attempts} --interval=#{interval} --job-concurrency=#{jobConcurrency}\"", ->
    it 'gets item id, from, size, concurrency, attempts, interval and jobConcurrency', ->
      match = regex.exec "#{baseInput} --from=#{from} --size=#{size} --concurrency=#{concurrency} --attempts=#{attempts} --interval=#{interval} --job-concurrency=#{jobConcurrency}"
      expect match[1]
        .to.be.equal itemId
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal size
      expect Number(match[4])
        .to.be.equal concurrency
      expect Number(match[5])
        .to.be.equal attempts
      expect Number(match[6])
        .to.be.equal interval
      expect Number(match[7])
        .to.be.equal jobConcurrency
      expect match[8]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --size=#{size} --concurrency=#{concurrency} --attempts=#{attempts} --interval=#{interval} --job-concurrency=#{jobConcurrency} --users=#{users}\"", ->

    it 'gets item url, from, concurrency, payment method, attempts, interval, jobConcurrency and users', ->

      match = regex.exec "#{baseInput} --from=#{from} --size=#{size} --concurrency=#{concurrency} --attempts=#{attempts} --interval=#{interval} --job-concurrency=#{jobConcurrency} --users=#{users}"
      expect match[1]
        .to.be.equal itemId
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal size
      expect Number(match[4])
        .to.be.equal concurrency
      expect Number(match[5])
        .to.be.equal attempts
      expect Number(match[6])
        .to.be.equal interval
      expect Number(match[7])
        .to.be.equal jobConcurrency
      expect match[8]
        .to.be.equal users
