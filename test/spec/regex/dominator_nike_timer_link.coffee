{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_nike_timer_link', ->

  url = 'http://m.nike.com/jp/ja_jp/pd/%E3%82%A8%E3%82%A2-%E3%82%B8%E3%83%A7%E3%83%BC%E3%83%80%E3%83%B3-7-%E3%83%AC%E3%83%88%E3%83%AD-%E3%83%A1%E3%83%B3%E3%82%BA%E3%82%B7%E3%83%A5%E3%83%BC%E3%82%BA/pid-11045504/pgid-11523606?cp=jpns_aff_150903_A8'
  baseInput = "test-robot: dominator nike-timer-link #{url}"
  from = '1986-12-02T00:00:00'
  size = '123456:27'
  attempts = '10'
  interval = '1000'
  concurrency = '2'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_nike_timer_link'

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
