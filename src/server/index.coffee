express = require 'express'
stylus = require 'stylus'
nib = require 'nib'
bootstrap = require 'bootstrap-styl'
mongoose = require 'mongoose'
session = require 'express-session'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
passport = require 'passport'
expressValidator = require 'express-validator'

# Basic application initialization
# Create app instance.
app = express()

# Define Port & Environment
app.port = process.env.PORT or process.env.VMC_APP_PORT or 3000
env = process.env.NODE_ENV or "development"

# Config module exports has `setEnvironment` function that sets app settings
# depending on environment.
config = require "./config"
config.setEnvironment env

if env != 'production'
  mongoose.connect(
    "mongodb://#{config.DB_HOST}:#{config.DB_PORT}/#{config.DB_NAME}")
else
  console.log('If you are running in production, you may want to modify the mongoose connect path')

# Config stylus.
compile = (str, path) ->
  stylus(str)
    .set('filename', path)
    .set('compress', true)
    .use(bootstrap())

app.use(stylus.middleware(
  src: process.cwd() + '/src'
  dest: process.cwd() + '/public'
  compile: compile
  debug: true
  force: true))
    

# Set the public folder as static assets.
app.use express.static(process.cwd() + '/public')

# Express Session
console.log "setting session/cookie"
app.use cookieParser()
app.use session(
  secret: "keyboard cat"
  key: "sid"
  cookie:
    secure: true
)
app.use expressValidator()

# Passport.
passportConf = require './config/passport'
app.use passport.initialize()
app.use passport.session()

# Set View Engine.
app.set 'view engine', 'jade'

# [Body parser middleware](http://www.senchalabs.org/connect/middleware-bodyParser.html)
# parses JSON or XML bodies into `req.body` object
app.use bodyParser()


# Finalization
# Initialize routes
routes = require './routes'
routes(app)


# Export application object
module.exports = app
