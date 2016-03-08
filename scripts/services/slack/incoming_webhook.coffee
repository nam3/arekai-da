request = require 'request'
HexColor = require '../../models/hex_color'

incomingWebhook = class SlackIncomingWebhook

  constructor: ({
    @incomingWebhookUrl
    @title
    @color
    @channel
  }) ->
    @_request = request

  send: (message) ->

    return new Promise (resolve, reject) =>

      slackAttachment =
        attachments: [
          fallback: message
          color: HexColor.skyblue
          fields: [
            value: message
          ]
          mrkdwn_in: ['fields']
        ]

      options =
        uri: @incomingWebhookUrl
        body: JSON.stringify slackAttachment

      @_request.post options, (err, res, body) ->

        if err
          reject err
          return

        if body isnt 'ok'
          reject body
          return

        resolve body

  notify: ({
    incomingWebhookUrl
    title
    text
    color
    channel
  }) ->
    incomingWebhookUrl ?= @incomingWebhookUrl
    title ?= @title
    color ?= @color
    #Specify such "channel-name" format when you choose private channel.
    channel ?= @channel

    return new Promise (resolve, reject) =>

      slackAttachment =
        attachments: [
          fallback: text
          color: color
          fields: [
            title: title
            value: text
          ]
          mrkdwn_in: ['fields']
        ]
      if channel
        slackAttachment.channel = channel

      options =
        uri: incomingWebhookUrl
        body: JSON.stringify slackAttachment

      @_request.post options, (err, res, body) ->

        if err
          reject err
          return

        if body isnt 'ok'
          reject body
          return

        resolve body

module.exports = incomingWebhook
