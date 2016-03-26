{Account} = require 'arekai-da-plugins'
CreditCard = require('arekai-da-plugins').CreditCard.Supreme
Supreme = require('arekai-da-plugins').Supreme.New
{Task} = require '../services/task'
utils = require '../utils/supreme'

module.exports = class BuySupremeNew

  constructor: ({
    @slackName
    @creditCardFlag
    @imgAlt
    @size
    @cronTime
    @dryrunFlag
  }) ->
    @account = new Account
      db: 'arekai-da'
      clientId: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_ID
      clientSecret: process.env.HUBOT_GOOGLE_API_OAUTH2_CLIENT_SECRET
      redirectUrn: process.env.HUBOT_GOOGLE_API_OAUTH2_REDIRECT_URN
      refreshToken: process.env.HUBOT_GOOGLE_API_OAUTH2_REFRESH_TOKEN

  execute: () =>

    @account.getAccount @slackName, 'supreme'
      .then (user) =>
        size = utils.convertToSupremeSize(@size) if @size
        creditCard = new CreditCard user.creditCardCompany, user.creditCardNumber, user.creditCardMonth, user.creditCardYear, user.securitycode  if @creditCardFlag
        supreme = new Supreme user.firstname, user.lastname, user.email, user.phonenumber, user.zipcode, user.state, user.city, user.address, @imgAlt, creditCard, size
        taskName = "#{@slackName}: Buying Supreme New Item #{@imgAlt}"
        fn = ->
          supreme.execute(@dryrunFlag)

        task = new Task taskName, fn, @cronTime

      .catch (err) ->
        errMessage = if 'stack' in Object.keys(err) then err.stack else err
        console.log errMessage
