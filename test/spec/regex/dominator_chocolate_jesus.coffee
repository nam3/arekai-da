{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_chocolate_jesus', ->
  keyword = 'GIRLS'
  searchUrl = 'http://shop.chocolatejesus.jp/?mode=grp&gid=1082518&sort=n'
  baseInput = "test-robot: dominator chocolate \"#{keyword}\" --search=#{searchUrl}"
  from = '1986-12-02T00:00:00'
  size = 'MEDIUM'
  attempts = 3
  interval = 2000
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_chocolate_jesus'
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
