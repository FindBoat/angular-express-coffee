passport = require 'passport'
LocalStrategy = require('passport-local').Strategy;
User = require '../models/user'


passport.serializeUser (user, done) ->
  done(null, user.id)

passport.deserializeUser (id, done) ->
  User.findById id, (err, user) ->
    done(err, user)

passport.use(new LocalStrategy(
  usernameField: 'email', (email, password, done) ->
    User.findOne {email: email}, (err, user) ->
      if err? then return done(err)
      if !user? then return done null, false, message: 'incorrect email'
      user.comparePassword password, (err, isMatch) ->
        if isMatch
          return done null, user
        else
          return done null, false, message: 'incorrect password'
  )
)

