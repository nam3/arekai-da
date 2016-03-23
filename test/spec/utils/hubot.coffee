Moment = require 'moment-timezone'
{expect} = require 'chai'

hubot = require '../../../scripts/utils/hubot'

describe 'hubot', ->

  describe '#isDryrun', ->

    context 'when hubot is runnig dry-run mode', ->

      before ->
        process.env.HUBOT_DRY_RUN = 'true'

      after ->
        process.env.HUBOT_DRY_RUN = ''

      it 'gets true', ->

        expect hubot.isDryrun()
          .to.be.equal true

    context 'when hubot is not running dry-run mode', ->

      before ->
        process.env.HUBOT_DRY_RUN = 'false'

      after ->
        process.env.HUBOT_DRY_RUN = ''

      it 'gets false', ->

        expect hubot.isDryrun()
          .to.be.equal false

  describe '#convert2Crontime', ->

    context 'with datetime="now"', ->

      it 'converts to datetime when elapses 16 seconds after current datetime', ->
        current = Moment.tz('Asia/Tokyo').toDate()
        diff = Math.round((hubot.convert2Crontime('now') - current) / 1000)

        expect diff
          .to.be.within 6, 10
