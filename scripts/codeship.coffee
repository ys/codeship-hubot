# Description:
#   Access Codeship status
#
# Commands:
#   hubot add ship ship_project ship_uuid - Save a projectUUID as an alias
#   hubot ship ship_project branch - Display project and branch status
#
# Author:
#   Yannick @yann_ck

module.exports = (robot) ->
  robot.respond /ship ?([\w.\-_]+) is (.*)/i, (msg) ->
    ship_project = msg.match[1].trim()
    ship_uuid = msg.match[2].trim()

    robot.brain.codeship ?= {}
    robot.brain.codeship[ship_project] = ship_uuid
    msg.send "Added ship #{ship_project}"

  robot.respond /ship status ([\w.\-_]+) at ([\w.\/-_]+)/i, (msg) ->
    ship_project = msg.match[1].trim()
    branch = msg.match[2].trim()
    robot.brain.codeship ?= {}
    get_status(robot.brain.codeship, msg, ship_project, branch)

  robot.respond /ship status ([\w.\-_]+)/i, (msg) ->
    ship_project = msg.match[1].trim()
    robot.brain.codeship ?= {}
    get_status(robot.brain.codeship, msg, ship_project, "master")

  get_status = (data, msg, ship_project, branch) ->
    ship_uuid = data[ship_project]
    if !ship_uuid
      return msg.send "You need to first add a ship with that name"
    codeship_status_url = "https://codeship-status.herokuapp.com/#{ship_uuid}/#{branch}"
    msg.http(codeship_status_url).get() (err, res, body) ->
      try
        json = JSON.parse(body)
        msg.send "branch status is : #{json.status}"
      catch error
        msg.send "Problem with ship"
