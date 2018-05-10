{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_feeet', ->
  itemListUrl = 'http://www.feeetshop.net/product-group/156'
  baseInput = "test-robot: dominator feeet #{itemListUrl}"
  from = '1986-12-02T00:00:00'
  attempts = 3
  interval = 2000
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_feeet'
  context "with input = \"#{baseInput} --from=#{from} --attempts=#{attempts} --interval=#{interval}\"", ->
    it 'gets item list url, from, attempts, interval', ->
      match = regex.exec "#{baseInput} --from=#{from} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal itemListUrl
      expect match[2]
        .to.be.equal from
      expect Number(match[3])
        .to.be.equal attempts
      expect Number(match[4])
        .to.be.equal interval
      expect match[5]
        .to.be.equal undefined
  context "with input = \"#{baseInput} --from=#{from} --attempts=#{attempts} --interval=#{interval} --users=#{users}\"", ->
    it 'gets item list url, from, attempts, interval and users', ->
      match = regex.exec "#{baseInput} --from=#{from} --attempts=#{attempts} --interval=#{interval} --users=#{users}"
      expect match[1]
        .to.be.equal itemListUrl
      expect match[2]
        .to.be.equal from
      expect Number(match[3])
        .to.be.equal attempts
      expect Number(match[4])
        .to.be.equal interval
      expect match[5]
        .to.be.equal users
