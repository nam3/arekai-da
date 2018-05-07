{expect} = require 'chai'
Helper = require '../../helper'

describe.only 'dominator_supreme_another_tab', ->
  keyword = 'Boxer Briefs'
  baseInput = "test-robot: dominator supreme-another-tab \"#{keyword}\""
  from = '1986-12-02T00:00:00'
  color = 'Black'
  size = 'Large'
  paymentMethod = 'credit-card'
  attempts = 3
  interval = 2000
  maxCheckoutDelay = 3000
  recaptchaFetcherMode = 'manual'
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_supreme_another_tab'

  context "with input = \"#{baseInput} --from=#{from} --size=#{size}\"", ->
    it 'gets search keyword, from, size', ->
      match = regex.exec "#{baseInput} --from=#{from} --size=#{size}"
      expect match[1]
        .to.be.equal keyword
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal undefined
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal undefined
      expect match[6]
        .to.be.equal undefined
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined
      expect match[9]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --color=#{color} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --max-checkout-delay=#{maxCheckoutDelay} --fetcher-mode=#{recaptchaFetcherMode} --users=#{users}\"", ->
    it 'gets search keyword, from, color, size, attempts, interval and users', ->
      match = regex.exec "#{baseInput} --from=#{from} --color=#{color} --size=#{size} --payment-method=#{paymentMethod} --attempts=#{attempts} --interval=#{interval} --max-checkout-delay=#{maxCheckoutDelay} --fetcher-mode=#{recaptchaFetcherMode} --users=#{users}"
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
      expect Number(match[6])
        .to.be.equal attempts
      expect Number(match[7])
        .to.be.equal interval
      expect Number(match[8])
        .to.be.equal maxCheckoutDelay
      expect match[9]
        .to.be.equal recaptchaFetcherMode
      expect match[10]
        .to.be.equal users
