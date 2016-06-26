{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_rakuten', ->

  # url: Medicom Toy snowball
  url = 'http://item.rakuten.co.jp/project1-6/4530958504283/'
  baseInput = "test-robot: dominator rakuten #{url}"
  from = '1986-12-02T00:00:00'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_rakuten'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only item url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal url

  context "with input = \"#{baseInput} --from=#{from}\"", ->

    it 'gets item url, start datetime', ->

      match = regex.exec "#{baseInput} --from=#{from}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal from
