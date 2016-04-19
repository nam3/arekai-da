{expect} = require 'chai'

Helper = require '../../helper'

describe 'buy_supreme_new', ->

  imgAlt = 'Ah-0sjsjorc'
  baseInput = "test-robot: buy supreme new #{imgAlt}"
  size = 's'
  creditCardFlag = 'false'
  from = '1986-12-02T00:00:00'
  interval = '1'
  times = '20'
  concurrency = '4'
  regex = Helper.importDispatcherRegex require '../../../scripts/buy_supreme_new'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal imgAlt

  context "with input = \"#{baseInput} --size=#{size}\"", ->

    it 'gets url and size',  ->

      match = regex.exec "#{baseInput} --size=#{size}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --credit-card=#{creditCardFlag}\"", ->

    it 'gets url and credit card flag',  ->

      match = regex.exec "#{baseInput} --credit-card=#{creditCardFlag}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal creditCardFlag
      expect match[4]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from}\"", ->

    it 'gets url and from',  ->

      match = regex.exec "#{baseInput} --from=#{from}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal from

  context "with input = \"#{baseInput} --size=#{size} --from=#{from}\"", ->

    it 'gets url, size and from',  ->

      match = regex.exec "#{baseInput} --size=#{size} --from=#{from}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal from

  context "with input = \"#{baseInput} --credit-card=#{creditCardFlag} --from=#{from}\"", ->

    it 'gets url, credit card flag and from',  ->

      match = regex.exec "#{baseInput} --credit-card=#{creditCardFlag} --from=#{from}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.undefined
      expect match[3]
        .to.be.equal creditCardFlag
      expect match[4]
        .to.be.equal from

  context "with input = \"#{baseInput} --size=#{size} --credit-card=#{creditCardFlag} --from=#{from}\"", ->

    it 'gets url, size, credit card flag and from',  ->

      match = regex.exec "#{baseInput} --size=#{size} --credit-card=#{creditCardFlag} --from=#{from}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal size
      expect match[3]
        .to.be.equal creditCardFlag
      expect match[4]
        .to.be.equal from

  context "with input = \"#{baseInput} --from=#{from} --interval=#{interval} --times=#{times}\"", ->

    it 'gets img alt attr, from, interval and times', ->

      match = regex.exec "#{baseInput} --from=#{from} --interval=#{interval} --times=#{times}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.undefined
      expect match[3]
        .to.be.undefined
      expect match[4]
        .to.be.equal from
      expect match[5]
        .to.be.equal interval
      expect match[6]
        .to.be.equal times
      expect match[7]
        .to.be.undefined

  context "with input = \"#{baseInput} --concurrency=#{concurrency}\"", ->

    it 'gets img alt attr and concurrency', ->

      match = regex.exec "#{baseInput} --concurrency=#{concurrency}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.undefined
      expect match[3]
        .to.be.undefined
      expect match[4]
        .to.be.undefined
      expect match[5]
        .to.be.undefined
      expect match[6]
        .to.be.undefined
      expect match[7]
        .to.be.equal concurrency
