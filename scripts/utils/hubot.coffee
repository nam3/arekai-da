is_dry_run = () ->

  return if process.env.HUBOT_DRY_RUN.toLowerCase() is 'true' then true else false

module.exports =
  isDryrun: is_dry_run
