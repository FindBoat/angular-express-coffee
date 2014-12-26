TokenInterceptor = ($window) ->
  request: (config) ->
    config.headers = config.headers or {}
    # We can't use authService due to circular dependency.
    token = $window.localStorage.getItem 'token'
    if token? then config.headers['x-access-token'] = token
    return config

TokenInterceptor.$inject = ['$window']

angular
  .module 'app.core'
  .factory 'TokenInterceptor', TokenInterceptor
