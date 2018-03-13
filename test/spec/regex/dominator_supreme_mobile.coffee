{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_ftc', ->

  keyword = 'kyne DECK'
  baseInput = "test-robot: dominator ftc \"#{keyword}\""
  from = '1986-12-02T00:00:00'
  color = 'BLACK'
  size = 'L'
  attempts = 3
  interval = 2000
  checkoutConcurrency = 16
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_ftc'

  context "with input = \"#{baseInput} --from=#{from} --size=#{size}\"", ->

    it 'gets item url, from, size', ->

      match = regex.exec "#{baseInput} --from=#{from} --size=#{size}"
      expect match[1]
        .to.be.equal keyword
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal undefined
      expect match[6]
        .to.be.equal undefined
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --color=#{color} --size=#{size} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets item url, from, color, size, attempts and interval', ->

      match = regex.exec "#{baseInput} --from=#{from} --color=#{color} --size=#{size} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal keyword
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal color
      expect match[4]
        .to.be.equal size
      expect Number(match[5])
        .to.be.equal attempts
      expect Number(match[6])
        .to.be.equal interval
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --color=#{color} --size=#{size} --attempts=#{attempts} --interval=#{interval} --checkout-concurrency=#{checkoutConcurrency} --users=#{users}\"", ->

    it 'gets item url, from, color, size, attempts, interval and users', ->

      match = regex.exec "#{baseInput} --from=#{from} --color=#{color} --size=#{size} --attempts=#{attempts} --interval=#{interval} --checkout-concurrency=#{checkoutConcurrency} --users=#{users}"
      expect match[1]
        .to.be.equal keyword
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal color
      expect match[4]
        .to.be.equal size
      expect Number(match[5])
        .to.be.equal attempts
      expect Number(match[6])
        .to.be.equal interval
      expect Number(match[7])
        .to.be.equal checkoutConcurrency
      expect match[8]
        .to.be.equal users
