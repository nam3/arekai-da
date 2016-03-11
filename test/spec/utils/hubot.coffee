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
