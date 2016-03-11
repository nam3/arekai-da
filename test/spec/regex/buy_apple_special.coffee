{expect} = require 'chai'

Helper = require '../../helper'

describe 'buy_apple_special', ->

  robot = undefined
  regex = undefined
  url = 'http://www.apple.com/jp/shop/product/FE182J/A/airmac-time-capsule-%E6%95%B4%E5%82%99%E6%B8%88%E8%A3%BD%E5%93%81-3tb'
  baseInput = "test-robot: buy apple special #{url}"
  regex = Helper.importDispatcherRegex require '../../../scripts/buy_apple_special'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal url

  context "with input = \"#{baseInput} --time=00 00 09 * * *\"", ->

    it 'gets url and time',  ->

      time = '00 00 09 * * *'
      match = regex.exec "#{baseInput} --time=#{time}"
      expect match[1]
        .to.be.equal url
      expect match[2]
        .to.be.equal time
