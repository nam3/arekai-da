{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_isetan', ->

  url = 'https://isetan.mistore.jp/onlinestore/product/0110900000000000000000427228.html'
  baseInput = "test-robot: dominator isetan #{url}"
  from = '1986-12-02T00:00:00'
  color = 'SAND'
  size = '27.0'
  attempts = 3
  interval = 2000
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_isetan'

  context "with input = \"#{baseInput} --from=#{from} --size=#{size}\"", ->

    it 'gets item url, from, size', ->

      match = regex.exec "#{baseInput} --from=#{from} --size=#{size}"
      expect match[1]
        .to.be.equal url
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

  context "with input = \"#{baseInput} --from=#{from} --color=#{color} --size=#{size} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets item url, from, color, size, attempts, interval', ->

      match = regex.exec "#{baseInput} --from=#{from} --color=#{color} --size=#{size} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal url
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
