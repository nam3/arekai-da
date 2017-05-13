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

  describe '#assumeStringAsBoolean', ->
    context 'with "true"', ->
      it 'returns true as boolean', ->
        expect hubot.assumeStringAsBoolean('true')
          .to.be.equal true
    context 'with "false"', ->
      it 'returns false as boolean', ->
        expect hubot.assumeStringAsBoolean('false')
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

  describe '#handleMultipleUser', ->
    resolve = (v) -> return v
    reject = (e) -> return e
    attempts = 1
    interval = 500
    context 'with existing user', ->
      it 'returns fulfilled Promise', ->
        userIds = ['test-user']
        type = 'test-type'
        return shouldFulfilled hubot.handleMultipleUser userIds, type, resolve, reject, attempts, interval
          .then (v) ->
            expect v
              .to.be.eql userIds

    context 'with no existing user', ->
      it 'rejects with not found user Error', ->
        userIds = ['non-existence-user']
        type = 'test-type'
        return shouldFulfilled hubot.handleMultipleUser userIds, type, resolve, reject, attempts, interval
          .then (e) ->
            expect e.message
              .to.be.eql 'Found no existing user. Did you TYPO?? haha!'

  describe '#convert2JstDatetime', ->
    context 'with valid datetime', ->
      it 'gets datetime with timezone +09:00 style', ->
        datetime = '1986-12-02T00:00:00'
        expected = '1986-12-02T00:00:00+09:00'
        expect hubot.convert2JstDatetime(datetime)
          .to.be.eql expected
