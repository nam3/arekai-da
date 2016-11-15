{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_nike_timer_link', ->

  url = 'http://calif.cc/brand/styles/item/STS0116F0480'
  baseInput = "test-robot: dominator calif #{url}"
  from = '1986-12-02T00:00:00'
  size = '27.0'
  attempts = '10'
  interval = '1000'
  concurrency = '2'
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_calif'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal url

  context "with input = \"#{baseInput} --from=#{from} --size=#{size} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets item url, from, size, attempts and interval', ->

      match = regex.exec "#{baseInput} --from=#{from} --size=#{size} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal url
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

    it 'gets url, from, size, attempts, interval and concurrency', ->

      match = regex.exec "#{baseInput} --from=#{from} --size=#{size} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal url
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

    it 'gets url, from, size, attempts, interval, concurrency and users', ->

      match = regex.exec "#{baseInput} --from=#{from} --size=#{size} --attempts=#{attempts} --interval=#{interval} --concurrency=#{concurrency} --users=#{users}"
      expect match[1]
        .to.be.equal url
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
