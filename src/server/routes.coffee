jwt = require './config/jwt'
postsCtrl = require './controllers/posts'
usersCtrl = require './controllers/users'


module.exports = (app) ->
  # Homepage.
  app.get '/', (req, res) ->
    res.render 'index'

  # For rendering jade tmpl.
  app.get '/client/*', (req, res) ->
    res.render req.param(0)
  
  # Posts API.
  app.post '/api/users/me/posts', jwt.jwtRequired, postsCtrl.createPost
  app.get '/api/users/me/posts', jwt.jwtRequired, postsCtrl.getPosts

  # Users API.
  app.post '/api/users', usersCtrl.signup
  app.post '/api/auth', usersCtrl.login
  app.get '/api/users/me', jwt.jwtRequired, usersCtrl.me


  # If all else failed, show 404 page
  app.all '/*', (req, res, next) ->
    console.warn 'error 404: ', req.url
    err = new Error
    err.status = 404
    return next err
