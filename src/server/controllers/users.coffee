User = require '../models/user'
passport = require 'passport'
util = require 'util'

module.exports =
  login: (req, res, next) ->
    req.assert('email', 'Email is not valid').isEmail();
    req.assert('password', 'Password cannot be blank').notEmpty();
    errors = req.validationErrors()
    if errors?
      res.status(400).send util.inspect(errors)
      return

    passport.authenticate('local', (err, user, info) ->
      if err? then return next(err)
      if not user
        res.status(400).send 'Invalid email or password'
        return
      req.logIn user, (err) ->
        if err? then return next(err)
        res.send user
      )(req, res, next)

  signup: (req, res, next) ->
    req.assert('email', 'Email is not valid').isEmail();
    req.assert(
      'password', 'Password must be at least 4 characters long').len(4);
    errors = req.validationErrors()
    if errors?
      res.status(400).send util.inspect(errors)
      return

    User.findOne email: req.body.email, (err, existingUser) ->
      if existingUser?
        res.status(400).send 'Email has been registered'
        return

      user = new User
        email: req.body.email
        password: req.body.password
      user.save (err) ->
        if err? then return next(err)
        req.logIn user, (err) ->
          if err? then return next(err)
          res.send user
        
