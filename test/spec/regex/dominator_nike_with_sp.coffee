{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_nike_with_sp', ->

  url = 'http://m.nike.com/jp/ja_jp/pd/%E3%83%8A%E3%82%A4%E3%82%AD-%E3%82%A8%E3%82%A2-%E3%83%9E%E3%83%83%E3%82%AF%E3%82%B9-1-%E3%82%A6%E3%83%AB%E3%83%88%E3%83%A9-%E3%83%95%E3%83%A9%E3%82%A4%E3%83%8B%E3%83%83%E3%83%88-%E3%83%A1%E3%83%B3%E3%82%BA%E3%82%B7%E3%83%A5%E3%83%BC%E3%82%BA/pid-11042744/pgid-11506397'
  baseInput = "test-robot: dominator nike-with-sp #{url}"
  from = '1986-12-02T00:00:00'
  size = '27'
  attempts = '10'
  interval = '1000'
  concurrency = '2'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_nike_with_sp'

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

  context "with input = \"#{baseInput} --from=#{from} --size=M --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets item url, from, size, attempts and interval', ->

      match = regex.exec "#{baseInput} --from=#{from} --size=M --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal 'M'
      expect match[4]
        .to.be.equal attempts
      expect match[5]
        .to.be.equal interval
      expect match[6]
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
