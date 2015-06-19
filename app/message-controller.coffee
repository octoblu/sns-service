SNS    = require 'sns-mobile'
config = require './config'
debug  = require('debug')('sns-service:message-controller')

class MessageController
  send: (request, response) =>
    arn = request.header 'X-SNS-ARN'
    endpoint = request.header 'X-SNS-Endpoint'
    platformId = request.header 'X-SNS-Platform'
    sandbox = request.header('X-SNS-Sandbox')?.toLocaleLowerCase() == 'true'

    app = @_createApp arn, platformId, sandbox
    message = @_createMessage request.body, sandbox

    app.sendMessage endpoint, message, (error, messageId) =>
      return response.status(500).send error: error.message if error?
      response.status(200).send messageId: messageId

  _createMessage: (message, sandbox) =>
    key = 'APNS'
    key = 'APNS_SANDBOX' if sandbox

    frame = {}
    frame[key] = JSON.stringify({
      aps:
        'content-available': 1
      message: message
    })

    return frame

  _createApp: (arn, platform, sandbox=false) =>
    new SNS
      platform: SNS.SUPPORTED_PLATFORMS[platform]
      region: 'us-west-2'
      apiVersion: '2010-03-31'
      accessKeyId: config.SNS_KEY_ID
      secretAccessKey: config.SNS_ACCESS_KEY
      platformApplicationArn: arn
      sandbox: sandbox



module.exports = MessageController
