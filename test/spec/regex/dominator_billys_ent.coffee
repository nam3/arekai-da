{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_billys_ent', ->
  itemId = '5455740001099'
  baseInput = "test-robot: dominator billys #{itemId}"
  from = '1986-12-02T00:00:00'
  concurrency = 1
  attempts = 16
  interval = 1000
  jobConcurrency = 2
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_billys_ent'

  context "with input = \"#{baseInput}\"", ->
    it 'gets only url', ->
      match = regex.exec baseInput
      expect match[1]
        .to.be.equal itemId

  context "with input = \"#{baseInput} --from=#{from} --concurrency=#{concurrency} --attempts=#{attempts} --interval=#{interval}\"", ->
    it 'gets item url, from, concurrency, attempts and interval', ->
      match = regex.exec "#{baseInput} --from=#{from} --concurrency=#{concurrency} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal itemId
      expect match[2]
        .to.be.equal from
      expect Number(match[3])
        .to.be.equal concurrency
      expect Number(match[4])
        .to.be.equal attempts
      expect Number(match[5])
        .to.be.equal interval
      expect match[6]
        .to.be.equal undefined
      expect match[7]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --concurrency=#{concurrency} --attempts=#{attempts} --interval=#{interval} --jobConcurrency=#{jobConcurrency}\"", ->

    it 'gets item url, from, concurrency, attempts, interval and jobConcurrency', ->

      match = regex.exec "#{baseInput} --from=#{from} --concurrency=#{concurrency} --attempts=#{attempts} --interval=#{interval} --jobConcurrency=#{jobConcurrency}"
      expect match[1]
        .to.be.equal itemId
      expect match[2]
        .to.be.equal from
      expect Number(match[3])
        .to.be.equal concurrency
      expect Number(match[4])
        .to.be.equal attempts
      expect Number(match[5])
        .to.be.equal interval
      expect Number(match[6])
        .to.be.equal jobConcurrency
      expect match[7]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --concurrency=#{concurrency} --attempts=#{attempts} --interval=#{interval} --jobConcurrency=#{jobConcurrency} --users=#{users}\"", ->

    it 'gets item url, from, concurrency, attempts, interval, jobConcurrency and users', ->

      match = regex.exec "#{baseInput} --from=#{from} --concurrency=#{concurrency} --attempts=#{attempts} --interval=#{interval} --jobConcurrency=#{jobConcurrency} --users=#{users}"
      expect match[1]
        .to.be.equal itemId
      expect match[2]
        .to.be.equal from
      expect Number(match[3])
        .to.be.equal concurrency
      expect Number(match[4])
        .to.be.equal attempts
      expect Number(match[5])
        .to.be.equal interval
      expect Number(match[6])
        .to.be.equal jobConcurrency
      expect match[7]
        .to.be.equal users
