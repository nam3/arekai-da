HexColor = require '../models/hex_color'

module.exports = (robot) ->

  # slack slash command to wakeup arekai-da
  robot.router.get '/wakeup', (req, res) ->
    token = req.query.token
    res.set
      'Content-Type': 'application/json'

    if not token or token isnt process.env.HUBOT_SLACK_SLASH_COMMAND_WAKEUP_TOKEN
      return res.send
        response_type: 'in_channel'
        text: 'Invalid token'
        attachments: [
          {
            color: HexColor.tomato
            text: 'Your provided token is invalid. Please set correct token as query string "token".'
          }
        ]

    res.send
      response_type: 'in_channel'
      attachments: [
        {
          color: HexColor.lightgreen
          text: 'Good Morning, Sir.:sun_with_face:'
        }
      ]
