{expect} = require 'chai'
Helper = require '../../helper'

describe 'dominator_supreme_with_browser', ->
  keyword = 'Boxer Briefs'
  baseInput = "test-robot: dominator supreme-browser \"#{keyword}\""
  from = '1986-12-02T00:00:00'
  color = 'White'
  size = 'Small'
  paymentMethod = 'credit-card'
  attempts = 3
  interval = 2000
  recaptchaFetcherType = 'manual'
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_supreme_with_browser'

  context "with input = \"#{baseInput} --from=#{from} --color=#{color} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval}\"", ->
    it 'gets item keyword, from, color, size, paymentMethod, attempts and interval', ->
      match = regex.exec "#{baseInput} --from=#{from} --color=#{color} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal keyword
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal color
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal paymentMethod
      expect Number match[6]
        .to.be.equal attempts
      expect Number match[7]
        .to.be.equal interval
      expect match[8]
        .to.be.equal undefined
      expect match[9]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --color=#{color} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --fetcher-mode=#{recaptchaFetcherType}\"", ->
    it 'gets item keyword, from, color, size, paymentMethod, attempts, interval and recaptchaFethcerType', ->
      match = regex.exec "#{baseInput} --from=#{from} --color=#{color} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --fetcher-mode=#{recaptchaFetcherType}"
      expect match[1]
        .to.be.equal keyword
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal color
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal paymentMethod
      expect Number match[6]
        .to.be.equal attempts
      expect Number match[7]
        .to.be.equal interval
      expect match[8]
        .to.be.equal recaptchaFetcherType
      expect match[9]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --color=#{color} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --fetcher-mode=#{recaptchaFetcherType} --users=#{users}\"", ->
    it 'gets full options', ->
      match = regex.exec "#{baseInput} --from=#{from} --color=#{color} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --fetcher-mode=#{recaptchaFetcherType} --users=#{users}"
      expect match[1]
        .to.be.equal keyword
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal color
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal paymentMethod
      expect Number match[6]
        .to.be.equal attempts
      expect Number match[7]
        .to.be.equal interval
      expect match[8]
        .to.be.equal recaptchaFetcherType
      expect match[9]
        .to.be.equal users
