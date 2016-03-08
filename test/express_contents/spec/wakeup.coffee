{expect} = require 'chai'
Robot = require 'hubot/src/robot'
request = require 'supertest'

describe 'GET /wakeup', ->

  app = undefined

  before ->
    process.env.HUBOT_SLACK_SLASH_COMMAND_WAKEUP_TOKEN = 'TOKEN'
    robot = new Robot null, 'mock-adapter', true, 'arekai-da'
    app = require('../../../scripts/express_contents/wakeup')(robot)

  context 'with correct token', ->

    it 'includes "Good Morning" in response message', (done) ->

      request(app).get('/wakeup?token=TOKEN').end (err, res) ->

        expect err
          .to.be.equal null
        expect res.body.attachments[0].text
          .to.match /Good\ Morning/
        done()

  context 'with invalid token', ->

    it 'includes "Your provided token is invalid" in response message', (done) ->

      request(app).get('/wakeup?token=INVALID').end (err, res) ->

        expect err
          .to.be.equal null
        expect res.body.attachments[0].text
          .to.match /Your\ provided\ token\ is\ invalid/
        done()

  context 'without token', ->

    it 'includes "Your provided token is invalid" in response message', (done) ->

      request(app).get('/wakeup').end (err, res) ->

        expect err
          .to.be.equal null
        expect res.body.attachments[0].text
          .to.match /Your\ provided\ token\ is\ invalid/
        done()
