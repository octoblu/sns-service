MessageController = require './message-controller'

class Router
  constructor: (@app) ->
    @messageController = new MessageController

  setup: =>
    @app.post '/message', @messageController.send 

module.exports = Router
