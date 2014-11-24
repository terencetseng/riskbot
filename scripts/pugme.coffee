# Description:
#   Pugme is the most important thing in your life
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot pug me - Receive a pug
#	hubot how many pugs are there - Cuanto pugs?
module.exports = (robot) ->

  robot.respond /pug me/i, (msg) ->
    msg.http("http://pugme.herokuapp.com/random")
      .get() (err, res, body) ->
        msg.send JSON.parse(body).pug

  robot.respond /pug bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5

    ignoreUsers = process.env.HUBOT_IRC_IGNORE_USERS?.split(",") or []
    sender = msg.message.user.mention_name

    if sender in ignoreUsers
      msg.send "@#{sender} I dont think that's a good idea"
    else if count > 50
      msg.send "@#{sender} http://38.media.tumblr.com/tumblr_m7l108S4z31rbd2hjo2_500.gif"
    else if count > 5
      msg.send "lets be nice"
    else
      msg.http("http://pugme.herokuapp.com/bomb?count=" + count)
        .get() (err, res, body) ->
          msg.send pug for pug in JSON.parse(body).pugs

  robot.respond /how many pugs are there/i, (msg) ->
    msg.http("http://pugme.herokuapp.com/count")
      .get() (err, res, body) ->
        msg.send "There are #{JSON.parse(body).pug_count} pugs."
