MessageController = require './message-controller'

class Router
  constructor: (@app) ->
    @messageController = new MessageController

  setup: =>
    @app.post '/messages', @messageController.send 

module.exports = Router
