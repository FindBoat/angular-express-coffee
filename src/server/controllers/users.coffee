jwt = require 'jsonwebtoken'
util = require 'util'
config = require '../config/config'
User = require '../models/users'

module.exports =
  login: (req, res, next) ->
    req.assert('email', 'Invalid email').isEmail()
    req.assert('password', 'Password cannot be blank').notEmpty()
    errors = req.validationErrors()
    if errors?
      err = new Error util.inspect(errors)
      err.status = 400
      return next err

    User.findOne email: req.body.email, (err, user) ->
      if err? then return next err
      if !user?
        error = new Error 'Incorret email'
        error.status = 400
        return next error
      user.comparePassword req.body.password, (err, isMatch) ->
        if not isMatch
          error = new Error 'Incorret password'
          error.status = 400
          return next error
        else
          token = jwt.sign(user,
                           config.JWT_SECRET,
                           expiresInMinutes: config.JWT_EXPIRES_IN_MINUTES)
          res.send
            token: token
            user: user

  signup: (req, res, next) ->
    req.assert('email', 'Invalid email').isEmail()
    req.assert(
      'password', 'Password must be at least 4 characters long').len(4)
    errors = req.validationErrors()
    if errors?
      err = new Error util.inspect(errors)
      err.status = 400
      return next err

    User.findOne email: req.body.email, (err, existingUser) ->
      if existingUser?
        error = new Error 'Email has been registered'
        error.status = 400
        return next error

      user = new User
        email: req.body.email
        password: req.body.password
      user.save (err) ->
        if err? then return next err
        token = jwt.sign(user,
                         config.JWT_SECRET,
                         expiresInMinutes: config.JWT_EXPIRES_IN_MINUTES)
        res.send
          token: token
          user: user

  me: (req, res) ->
    res.send req.user
        
