{expect} = require 'chai'

Helper = require '../../helper'

describe 'rank_supreme_sold_out_items', ->

  imgAlt = 'xxx'
  baseInput = "test-robot: supreme-sold-out-ranking \"#{imgAlt}\""
  from = '1986-12-02T00:00:00'
  maxItems = 20
  attempts = 3
  interval = 1000
  regex = Helper.importDispatcherRegex require '../../../scripts/rank_supreme_sold_out_items'

  context "with input = \"#{baseInput} --from=#{from} --max-item=#{maxItems} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets image alt, from, max item length, attempts, interval', ->

      match = regex.exec "#{baseInput} --from=#{from} --max-item=#{maxItems} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal imgAlt
      expect match[2]
        .to.be.equal from
      expect Number(match[3])
        .to.be.equal maxItems
      expect Number(match[4])
        .to.be.equal attempts
      expect Number(match[5])
        .to.be.equal interval
