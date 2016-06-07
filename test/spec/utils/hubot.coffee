_ = require 'lodash'
Moment = require 'moment-timezone'
{expect} = require 'chai'
{shouldFulfilled, shouldRejected} = require 'promise-test-helper'

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

  describe '#generatePromises', ->
    context 'with number = 10', ->
      it 'generates 10 promises as array', ->
        promises = hubot.generatePromises(10, -> return Promise.resolve('Hahaha'))
        expect promises
          .to.have.length 10

        shouldFulfilled(Promise.all(promises)).then (v) ->
          expect v
            .to.have.length 10
          expect _.sample(v)
            .to.be.equal 'Hahaha'
