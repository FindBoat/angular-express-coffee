express = require 'express'
stylus = require 'stylus'
nib = require 'nib'
bootstrap = require 'bootstrap-styl'
mongoose = require 'mongoose'
bodyParser = require 'body-parser'
expressValidator = require 'express-validator'
config = require './config/config'
routes = require './routes'


app = express()

# Define Port & Environment.
app.port = process.env.PORT or process.env.VMC_APP_PORT or 3000
env = process.env.NODE_ENV or 'dev'
config.setEnvironment env

# Config mongo db.
mongoose.connect(
  "mongodb://#{config.DB_HOST}:#{config.DB_PORT}/#{config.DB_NAME}")

# Config stylus.
compile = (str, path) ->
  stylus str
    .set 'filename', path
    .set 'compress', true
    .use bootstrap()
    .use nib()

app.use stylus.middleware
  src: process.cwd() + '/src'
  dest: process.cwd() + '/public'
  compile: compile
  debug: true
  force: true
    
# Config public static folder.
app.use express.static(process.cwd() + '/public')

app.use expressValidator()
app.use bodyParser()

# Config view engine.
app.set 'view engine', 'jade'
app.set 'views', process.cwd() + '/src/client'

# Config routes.
routes(app)

# Error handling.
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.send err.message
  console.log "HTTP #{err.status}: #{err.message}"
  return


# Export application object.
module.exports = app
