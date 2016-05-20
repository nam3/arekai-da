{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_supreme', ->

  imgAlt = 'Ub00hq4v3dw'
  baseInput = "test-robot: dominator supreme #{imgAlt}"
  from = '1986-12-02T00:00:00'
  interval = '1'
  times = '20'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_supreme'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only image alt attribute', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal imgAlt

  context "with input = \"#{baseInput} --from=#{from} --interval=#{interval} --times=#{times}\"", ->

    it 'gets image alt, from, interval and times', ->

      match = regex.exec "#{baseInput} --from=#{from} --interval=#{interval} --times=#{times}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal interval
      expect match[4]
        .to.be.equal times
      expect match[5]
        .to.be.equal undefined
