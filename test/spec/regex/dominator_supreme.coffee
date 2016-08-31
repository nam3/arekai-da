{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_supreme', ->

  imgAlt = 'xxx'
  baseInput = "test-robot: dominator supreme #{imgAlt}"
  from = '1986-12-02T00:00:00'
  category = 'accessories'
  size = 'Small'
  paymentMethod = 'cod'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_supreme'

  context "with input = \"#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod}\"", ->

    it 'gets image alt, from, category, size, paymentMethod', ->

      match = regex.exec "#{baseInput} --from=#{from} --category=#{category} --size=#{size} --payment-method=#{paymentMethod}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal category
      expect match[4]
        .to.be.equal size
      expect match[5]
        .to.be.equal paymentMethod
