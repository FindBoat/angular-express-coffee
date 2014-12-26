jwt = require 'jsonwebtoken'
config = require './config'

module.exports =
  jwtRequired: (req, res, next) ->
    jwt.verify req.headers['x-access-token'], config.JWT_SECRET, (err, user) ->
      if err
        err.status or= 401
        return next err
      if !user?
        error = new Error 'Invalid JWT token'
        error.status = 401
        return next error

      req.user = user
      next()
