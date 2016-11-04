{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_rakuten_books', ->

  url = 'https://www.medicomtoy.co.jp/s32/bea_mn/kakuningamen.html'
  baseInput = "test-robot: dominator medicomtoy #{url}"
  from = '1986-12-02T00:00:00'
  concurrency = '2'
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_medicomtoy'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal url

  context "with input = \"#{baseInput} --from=#{from}\"", ->

    it 'gets item url and from', ->

      match = regex.exec "#{baseInput} --from=#{from}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --concurrency=#{concurrency}\"", ->

    it 'gets item url, from and concurrency', ->

      match = regex.exec "#{baseInput} --from=#{from} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal concurrency
      expect match[4]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --concurrency=#{concurrency} --users=#{users}\"", ->

    it 'gets item url, from, concurrency and users', ->

      match = regex.exec "#{baseInput} --from=#{from} --concurrency=#{concurrency} --users=#{users}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal concurrency
      expect match[4]
        .to.be.equal users
