{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_supreme', ->

  imgAlt = 'xxx'
  baseInput = "test-robot: dominator supreme #{imgAlt}"
  from = '1986-12-02T00:00:00'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_supreme'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only image alt attribute', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal imgAlt

  context "with input = \"#{baseInput} --from=#{from}\"", ->

    it 'gets image alt, from', ->

      match = regex.exec "#{baseInput} --from=#{from}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal from
