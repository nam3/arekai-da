{expect} = require 'chai'
Helper = require '../../helper'

describe 'dominator_supreme_mobile', ->

  keyword = 'Warm-Up Jacket'
  baseInput = "test-robot: dominator supreme-mobile \"#{keyword}\""
  from = '1986-12-02T00:00:00'
  color = 'Black'
  size = 'Large'
  attempts = 3
  interval = 2000
  recaptchaFetcherMode = 'auto'
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_supreme_mobile'

  context "with input = \"#{baseInput} --from=#{from} --size=#{size}\"", ->
    it 'gets item url, from, size', ->
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

  context "with input = \"test-robot: dominator supreme-mobile \"Supreme/Nike/NBA Teams Warm-Up Jacket\" --from=#{from} --size=#{size}\"", ->
    it 'gets item url, from, size', ->
      match = regex.exec "test-robot: dominator supreme-mobile \"Supreme/Nike/NBA Teams Warm-Up Jacket\" --from=#{from} --size=#{size}"
      expect match[1]
        .to.be.equal 'Supreme/Nike/NBA Teams Warm-Up Jacket'
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

  context "with input = \"#{baseInput} --from=#{from} --color=#{color} --attempts=#{attempts} --interval=#{interval}\"", ->
    it 'gets search keyword, from, size, attempts and interval', ->
      match = regex.exec "#{baseInput} --from=#{from} --color=#{color} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal keyword
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal color
      expect match[4]
        .to.be.equal undefined
      expect Number(match[5])
        .to.be.equal attempts
      expect Number(match[6])
        .to.be.equal interval
      expect match[7]
        .to.be.equal undefined
      expect match[8]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --color=#{color} --size=#{size} --attempts=#{attempts} --interval=#{interval} --recaptcha-mode=#{recaptchaFetcherMode}\"", ->
    it 'gets search keyword, from, color, size, attempts and interval', ->
      match = regex.exec "#{baseInput} --from=#{from} --color=#{color} --size=#{size} --attempts=#{attempts} --interval=#{interval} --recaptcha=mode=#{recaptchaFetcherMode}"
      expect match[1]
        .to.be.equal keyword
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal color
      expect match[4]
        .to.be.equal size
      expect Number(match[5])
        .to.be.equal attempts
      expect Number(match[6])
        .to.be.equal interval
      expect match[7]
        .to.be.equal recaptchaFetcherMode
      expect match[8]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --color=#{color} --size=#{size} --attempts=#{attempts} --interval=#{interval} --recaptcha=mode=#{recaptchaFetcherMode} --users=#{users}\"", ->
    it 'gets search keyword, from, color, size, attempts, interval and users', ->
      match = regex.exec "#{baseInput} --from=#{from} --color=#{color} --size=#{size} --attempts=#{attempts} --interval=#{interval}  --recaptcha=mode=#{recaptchaFetcherMode}--users=#{users}"
      expect match[1]
        .to.be.equal keyword
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal color
      expect match[4]
        .to.be.equal size
      expect Number(match[5])
        .to.be.equal attempts
      expect Number(match[6])
        .to.be.equal interval
      expect match[7]
        .to.be.equal recaptchaFetcherMode
      expect match[8]
        .to.be.equal users
