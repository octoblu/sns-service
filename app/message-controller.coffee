SNS    = require 'sns-mobile'
config = require './config'

class MessageController
  constructor: ->

  send: (request, response) =>
    {deviceId, message} = request.body
    iosApp = @_createIOSApp()
    @_addUser iosApp, deviceId, (error, endpoint) =>
      return response.status(500).send error: error.message if error?
      @_sendMessage endpoint, message, (error, messageId) =>
        return response.status(500).send error: error.message if error?
        response.status(200).send sent: true, messageId: messageId

  _addUser: (app, deviceId, callback=->) =>
    data = JSON.stringify type:'meshblu:device'
    app.addUser deviceId, data, callback

  _createIOSApp: (ARN) =>
    new SNS
      platform: SNS.SUPPORTED_PLATFORMS.IOS,
      region: 'us-west-2',
      apiVersion: '2010-03-31',
      accessKeyId: config.SNS_KEY_ID,
      secretAccessKey: config.SNS_ACCESS_KEY,
      platformApplicationArn: ARN,
      sandbox: true

  _sendMessage: (endpoint, message, callback=->) =>
    endpoint.sendMessage endpoint, message, callback

module.exports = MessageController
