{expect} = require 'chai'

Helper = require '../../helper'

describe 'buy_nike_shoe', ->

  url = 'http://www.supremenewyork.com/shop/accessories/keychain-pen/stainless-steel'
  baseInput = "test-robot: buy supreme #{url}"
  regex = Helper.importDispatcherRegex require '../../../scripts/buy_supreme'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec "#{baseInput}"
      expect match[1]
        .to.be.equal url

  context "with input = \"#{baseInput}\"", ->

    it 'gets url and time',  ->

      time = '00 00 11 * * *'
      match = regex.exec "#{baseInput} --time=#{time}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal time
