# Sets application config parameters depending on `env` name
exports.setEnvironment = (env) ->
  console.log "Set app environment: #{env}"
  switch(env)
    when 'dev'
      exports.DEBUG_LOG = true
      exports.DEBUG_WARN = true
      exports.DEBUG_ERROR = true
      exports.DEBUG_CLIENT = true

      exports.DB_HOST = 'localhost'
      exports.DB_PORT = '27017'
      exports.DB_NAME = 'example'

      exports.JWT_SECRET = 'jwtsecret'
      exports.JWT_EXPIRES_IN_MINUTES = 30 * 60 * 24 # A month.

    when 'prod'
      exports.DEBUG_LOG = false
      exports.DEBUG_WARN = false
      exports.DEBUG_ERROR = true
      exports.DEBUG_CLIENT = false
    else
      console.log "Environment #{env} not found"
