{expect} = require 'chai'

SupremeUtils = require '../../../scripts/utils/supreme'

describe 'SupremeUtils', ->

  context '', ->

    describe '#convertToSupremeSize', ->

      convert = SupremeUtils.convertToSupremeSize

      context 'with sizeShortHand = "s"', ->

        it 'returns Small', ->
          expect convert 's'
            .to.be.equal 'Small'

      context 'with sizeShortHand = "S"', ->

        it 'returns also Small in UPPER CASE', ->
          expect convert 'S'
            .to.be.equal 'Small'

      context 'with sizeShortHand = "Invalid Size"', ->

        it 'throw invalid size error', ->
          fn = ->
            convert 'Invalid Size'

          expect fn
            .to.throw Error, /You must choose size in/
