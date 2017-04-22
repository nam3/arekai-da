{expect} = require 'chai'

Helper = require '../../helper'

describe 'dominator_epark', ->

  shopLocation = 'ginza'
  baseInput = "test-robot: dominator epark #{shopLocation}"
  from = '1986-12-02T00:00:00'
  reservationDatetime = '1986-12-02T13:00'
  attempts = 3
  interval = 2000
  users = 'user001,user002'
  regex = Helper.importDispatcherRegex require '../../../scripts/dominator_epark'

  context "with input = \"#{baseInput} --from=#{from} --reservation-datetime=#{reservationDatetime}\"", ->

    it 'gets shop location, from, reservation-datetime', ->

      match = regex.exec "#{baseInput} --from=#{from} --reservation-datetime=#{reservationDatetime}"
      expect match[1]
        .to.be.equal shopLocation
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal reservationDatetime
      expect match[4]
        .to.be.equal undefined
      expect match[5]
        .to.be.equal undefined
      expect match[6]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --reservation-datetime=#{reservationDatetime} --attempts=#{attempts} --interval=#{interval}\"", ->

    it 'gets item shop location, from, color, size, attempts and interval', ->

      match = regex.exec "#{baseInput} --from=#{from} --reservation-datetime=#{reservationDatetime} --attempts=#{attempts} --interval=#{interval}"
      expect match[1]
        .to.be.equal shopLocation
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal reservationDatetime
      expect Number(match[4])
        .to.be.equal attempts
      expect Number(match[5])
        .to.be.equal interval
      expect match[6]
        .to.be.equal undefined

  context "with input = \"#{baseInput} --from=#{from} --reservation-datetime=#{reservationDatetime} --attempts=#{attempts} --interval=#{interval} --users=#{users}\"", ->

    it 'gets item shop location, from, color, size, attempts and interval', ->

      match = regex.exec "#{baseInput} --from=#{from} --reservation-datetime=#{reservationDatetime} --attempts=#{attempts} --interval=#{interval} --users=#{users}"
      expect match[1]
        .to.be.equal shopLocation
      expect match[2]
        .to.be.equal from
      expect match[3]
        .to.be.equal reservationDatetime
      expect Number(match[4])
        .to.be.equal attempts
      expect Number(match[5])
        .to.be.equal interval
      expect match[6]
        .to.be.equal users
