{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_nike', ->

  url = 'http://www.nike.com/jp/ja_jp/'
  baseInput = "test-robot: dominator nike #{url}"
  size = '27'
  from = '1986-12-02T00:00:00'
  interval = '1'
  times = '20'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_nike'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal url

  context "with input = \"#{baseInput} --size=#{size} --from=#{from} --interval=#{interval} --times=#{times}\"", ->

    it 'gets image alt, from, interval and times', ->

      match = regex.exec "#{baseInput} --size=#{size} --from=#{from} --interval=#{interval} --times=#{times}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal from
      expect match[4]
        .to.be.equal interval
      expect match[5]
        .to.be.equal times
      expect match[6]
        .to.be.equal undefined
