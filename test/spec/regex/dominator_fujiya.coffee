{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_fujiya', ->

  url = 'http://www.family-town.jp/products/detail.php?product_id=266'
  baseInput = "test-robot: dominator fujiya #{url}"
  from = '1986-12-02T00:00:00'
  attempts = '20'
  interval = '1000'
  concurrency = '3'
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_fujiya'

  context "with input = \"#{baseInput}\"", ->
    it 'gets url', ->
      match = regex.exec baseInput
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal undefined
      expect match[5]
        .to.be.equal undefined
      expect match[6]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets item url, from, attempts and interval', ->

      match = regex.exec "#{baseInput} --from=#{from} --attempts=#{attempts }--interval=#{interval}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal attempts
      expect match[4]
        .to.be.equal interval
      expect match[5]
        .to.be.equal undefined
      expect match[6]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}\"", ->

    it 'gets item url, from, attempts, interval and concurrency', ->

      match = regex.exec "#{baseInput} --from=#{from} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal attempts
      expect match[4]
        .to.be.equal interval
      expect match[5]
        .to.be.equal concurrency
      expect match[6]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --attempts=#{attempts} --interval=#{interval} --users=#{users}\"", ->

    it 'gets item url, from, attempts, interval, and users', ->

      match = regex.exec "#{baseInput} --from=#{from} --attempts=#{attempts} --interval=#{interval} --users=#{users}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal attempts
      expect match[4]
        .to.be.equal interval
      expect match[5]
        .to.be.equal undefined
      expect match[6]
        .to.be.equal users

  context "with input = \"#{baseInput} --from=#{from} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency} --users=#{users}\"", ->

    it 'gets item url, from, attempts, interval, concurrency and users', ->

      match = regex.exec "#{baseInput} --from=#{from} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency} --users=#{users}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal attempts
      expect match[4]
        .to.be.equal interval
      expect match[5]
        .to.be.equal concurrency
      expect match[6]
        .to.be.equal users
