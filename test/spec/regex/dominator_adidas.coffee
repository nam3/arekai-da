{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_adidas', ->

  item1 = 'http://shop.adidas.jp/products/BB3070/'
  item2 = 'http://shop.adidas.jp/pc/item/detail.cgi?brand_code=110&itemCd=110_BB3070&itemGrcd=110_CCC49&itemDir1=16FW'
  item3 = 'http://shop.adidas.jp/products/BB3068/'
  item4 = 'http://shop.adidas.jp/pc/item/detail.cgi?brand_code=110&itemCd=110_BB3068&itemGrcd=110_CCC48&itemDir1=16FW'
  baseInput = "test-robot: dominator adidas --item1=#{item1}"
  size = '27.0'
  from = '1986-12-02T00:00:00'
  attempts = '4096'
  interval = '3000'
  checkoutConcurrency = '4'
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_adidas'

  context "with input = \"#{baseInput}\"", ->

    it 'gets only url', ->

      match = regex.exec baseInput
      expect match[1]
        .to.be.equal item1

  context "with input = \"#{baseInput} --size=#{size} --from=#{from} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets item1 url, from, interval and attempts', ->

      match = regex.exec "#{baseInput} --size=#{size} --from=#{from} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal item1
      expect match[2]
        .to.be.equal undefined
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal undefined
      expect match[5]
        .to.be.equal undefined
      expect match[6]
        .to.be.equal undefined
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined
      expect match[9]
        .to.be.equal size
      expect match[10]
        .to.be.equal from
      expect match[11]
        .to.be.equal attempts
      expect match[12]
        .to.be.equal interval
      expect match[13]
        .to.be.equal undefined
      expect match[14]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --item2=#{item2} --size=#{size} --from=#{from} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets item1 url, item2 url, from, interval and attempts', ->

      match = regex.exec "#{baseInput} --item2=#{item2} --size=#{size} --from=#{from} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal item1
      expect match[2]
        .to.be.equal item2
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal undefined
      expect match[5]
        .to.be.equal undefined
      expect match[6]
        .to.be.equal undefined
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined
      expect match[9]
        .to.be.equal size
      expect match[10]
        .to.be.equal from
      expect match[11]
        .to.be.equal attempts
      expect match[12]
        .to.be.equal interval
      expect match[13]
        .to.be.equal undefined
      expect match[14]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --item2=#{item2} --size=#{size} --from=#{from} --attempts=#{attempts} --interval=#{interval} --checkout-concurrency=#{checkoutConcurrency}\"", ->

    it 'gets item1 url, item2 url, from, interval, attempts and checkout concurrency', ->

      match = regex.exec "#{baseInput} --item2=#{item2} --size=#{size} --from=#{from} --attempts=#{attempts} --interval=#{interval} --checkout-concurrency=#{checkoutConcurrency}"
      expect match[1]
        .to.be.equal item1
      expect match[2]
        .to.be.equal item2
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal undefined
      expect match[5]
        .to.be.equal undefined
      expect match[6]
        .to.be.equal undefined
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined
      expect match[9]
        .to.be.equal size
      expect match[10]
        .to.be.equal from
      expect match[11]
        .to.be.equal attempts
      expect match[12]
        .to.be.equal interval
      expect match[13]
        .to.be.equal checkoutConcurrency
      expect match[14]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --item2=#{item2} --size=#{size} --from=#{from} --attempts=#{attempts} --interval=#{interval} --checkout-concurrency=#{checkoutConcurrency} --users=#{users}\"", ->

    it 'gets item1 url, item2 url, from, interval, attempts, checkout concurrency and users', ->

      match = regex.exec "#{baseInput} --item2=#{item2} --size=#{size} --from=#{from} --attempts=#{attempts} --interval=#{interval} --checkout-concurrency=#{checkoutConcurrency} --users=#{users}"
      expect match[1]
        .to.be.equal item1
      expect match[2]
        .to.be.equal item2
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal undefined
      expect match[5]
        .to.be.equal undefined
      expect match[6]
        .to.be.equal undefined
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined
      expect match[9]
        .to.be.equal size
      expect match[10]
        .to.be.equal from
      expect match[11]
        .to.be.equal attempts
      expect match[12]
        .to.be.equal interval
      expect match[13]
        .to.be.equal checkoutConcurrency
      expect match[14]
        .to.be.equal users
