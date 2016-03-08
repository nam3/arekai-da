{expect} = require 'chai'
{stub} = require 'sinon'

SlackIncomingWebhook = require '../../../../scripts/services/slack/incoming_webhook'

describe 'SlackIncomingWebhook', ->

  incomingWebhook = undefined

  beforeEach ->
    incomingWebhook = new SlackIncomingWebhook
      incomingWebhookUrl: 'https://slack-incoming-webhook-url.example.com'
      title: 'test slack incoming webhook'

  afterEach ->
    incomingWebhook._request.post.restore()

  context 'when calling slack API is succeeded', ->

    beforeEach ->

      stub incomingWebhook._request, 'post'
        .yields null, null, 'ok'

    describe '#notify', ->

      context 'with {text: "slack incoming webhook notify test"}', ->

        it 'gets "ok" as response body', ->

          incomingWebhook.notify {text: 'slack incoming webhook notify test'}
            .then (result) ->

              expect result
                .to.be.equal 'ok'

    describe '#send', ->

      context 'with message = "test message"', ->

        it 'gets "ok" as response body', ->

          incomingWebhook.send 'test message'
            .then (result) ->

              expect result
                .to.be.equal 'ok'

  context 'when calling slack API is failed', ->

    describe '#notify', ->

      context 'with {text: "failed test", channel: "invalid-channel"}', ->

        beforeEach ->

          stub incomingWebhook._request, 'post'
            .yields null, null, 'Invalid channel specified'

        it 'throws err', ->

          params =
            text: 'failed test'
            channel: 'invalid-channel'
          incomingWebhook.notify params
            .then -> throw Error "This test throws Error"
            .catch (err) ->

              expect err
                .to.be.equal 'Invalid channel specified'
