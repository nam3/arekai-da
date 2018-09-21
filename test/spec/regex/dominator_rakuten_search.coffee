{expect} = require 'chai'
Helper = require '../../helper'

describe 'dominator_chocolate_jesus', ->
  keyword = '861428-061'
  searchUrl = 'https://item.rakuten.co.jp/mitasneakers/c/0000000100/?s=4&i=1#risFil'
  baseInput = "test-robot: dominator rakuten-mita \"#{keyword}\" --search=#{searchUrl}"
  from = '1986-12-02T00:00:00'
  size = '27.0'
  attempts = 3
  interval = 2000
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_rakuten_mita_sneakers'
  context "with input = \"#{baseInput} --from=#{from} --size=#{size}\"", ->
    it 'gets item url, from, size', ->
      match = regex.exec "#{baseInput} --from=#{from} --size=#{size}"
      expect match[1]
        .to.be.equal keyword
      expect match[2]
        .to.be.equal searchUrl
      expect match[3]
        .to.be.equal from
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
  context "with input = \"#{baseInput} --from=#{from} --size=#{size} --attempts=#{attempts} --interval=#{interval} --users=#{users}\"", ->
    it 'gets item url, from, size', ->
      match = regex.exec "#{baseInput} --from=#{from} --size=#{size} --attempts=#{attempts} --interval=#{interval} --users=#{users}"
      expect match[1]
        .to.be.equal keyword
      expect match[2]
        .to.be.equal searchUrl
      expect match[3]
        .to.be.equal from
      expect match[4]
        .to.be.equal size
      expect Number(match[5])
        .to.be.equal attempts
      expect Number(match[6])
        .to.be.equal interval
      expect match[7]
        .to.be.equal users
