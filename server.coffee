path               = require 'path'
morgan             = require 'morgan'
express            = require 'express'
bodyParser         = require 'body-parser'
errorHandler       = require 'errorhandler'
meshbluHealthcheck = require 'express-meshblu-healthcheck'
Router             = require './app/router'

port = process.env.SNS_PORT || process.env.PORT || 8003

app = express();
app.set 'port', port
app.use bodyParser.json()
app.use morgan('dev')
app.use express.static(path.join(__dirname, 'public'))
app.use errorHandler()
app.use meshbluHealthcheck()

router = new Router(app)
router.setup()

app.listen app.get('port'), ->
  console.log("SNS Service listing on " + app.get('port'));
