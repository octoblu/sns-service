SNS    = require 'sns-mobile'
config = require './config'

class MessageController
  constructor: ->

  send: (request, response) =>
    arn = request.header 'X-SNS-ARN'
    deviceId = request.header 'X-SNS-Device'
    platformId = request.header 'X-SNS-Platform'

    app = @_createApp arn, platformId
    @_addUser app, deviceId, (error, endpoint) =>
      return response.status(500).send error: error.message if error?
      @_sendMessage endpoint, message, (error, messageId) =>
        return response.status(500).send error: error.message if error?
        response.status(200).send sent: true, messageId: messageId

  _addUser: (app, deviceId, callback=->) =>
    data = JSON.stringify type:'meshblu:device'
    app.addUser deviceId, data, callback

  _createApp: (arn, platform) =>
    new SNS
      platform: SNS.SUPPORTED_PLATFORMS[platform]
      region: 'us-west-2'
      apiVersion: '2010-03-31'
      accessKeyId: config.SNS_KEY_ID
      secretAccessKey: config.SNS_ACCESS_KEY
      platformApplicationArn: arn
      sandbox: true

  _sendMessage: (endpoint, message, callback=->) =>
    endpoint.sendMessage endpoint, message, callback

module.exports = MessageController
