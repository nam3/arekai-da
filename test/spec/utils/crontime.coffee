Moment = require 'moment-timezone'

{expect} = require 'chai'

crontime = require '../../../scripts/utils/crontime'

describe 'crontime', ->

  describe '#convert2Crontime', ->

    context 'with datetime="now"', ->

      it 'converts to datetime when elapses 16 seconds after current datetime', ->
        current = Moment.tz('Asia/Tokyo').toDate()
        diff = Math.round((crontime.convert2Crontime('now') - current) / 1000)

        expect diff
          .to.be.within 10, 20
