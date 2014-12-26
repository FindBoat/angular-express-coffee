config =
  appTitle: 'Angular Modular Demo'
  version: '0.0.1'

configure = (
  $httpProvider,
  $routeProvider,
  routehelperConfigProvider
) ->
  routehelperConfigProvider.config.$routeProvider = $routeProvider
  routehelperConfigProvider.config.docTitle = 'App | '

  $httpProvider.interceptors.push 'ErrorInterceptor'
  $httpProvider.interceptors.push 'TokenInterceptor'

  # Maybe set resolveAlways here.
  return

configure.$inject = ['$httpProvider', '$routeProvider',
    'routehelperConfigProvider']

angular
  .module 'app.core'
  .value 'config', config
  .config configure

