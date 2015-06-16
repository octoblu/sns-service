DeviceController = require './device-controller'
MessageController = require './message-controller'

class Router
  constructor: (@app) ->
    @deviceController = new DeviceController
    @messageController = new MessageController

  setup: =>
    @app.post '/devices', @deviceController.create
    @app.post '/messages', @messageController.send

module.exports = Router
