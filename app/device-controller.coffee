SNS    = require 'sns-mobile'
config = require './config'

class DeviceController
  create: (request, response) =>
    arn = request.header 'X-SNS-ARN'
    deviceId = request.header 'X-SNS-Device'
    platformId = request.header 'X-SNS-Platform'
    sandbox = request.header('X-SNS-Sandbox')?.toLocaleLowerCase() == 'true'

    app = @_createApp arn, platformId, sandbox
    @_addUser app, deviceId, (error, endpoint) =>
      return response.status(500).send error: error.message if error?
      response.status(200).send endpoint: endpoint

  _addUser: (app, deviceId, callback=->) =>
    data = JSON.stringify type:'meshblu:device'
    app.addUser deviceId, data, callback

  _createApp: (arn, platform, sandbox=false) =>
    new SNS
      platform: SNS.SUPPORTED_PLATFORMS[platform]
      region: 'us-west-2'
      apiVersion: '2010-03-31'
      accessKeyId: config.SNS_KEY_ID
      secretAccessKey: config.SNS_ACCESS_KEY
      platformApplicationArn: arn
      sandbox: sandbox

module.exports = DeviceController
