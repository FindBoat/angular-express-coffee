RouteConfig = ($location, $rootScope, authService, logger) ->
  checkLogin = ->
    $rootScope.$on '$routeChangeStart', (event, next, current) ->
      if next.loginRequired and not authService.isLogin()
        destination = (next and (next.title or next.name or
            next.loadedTemplateUrl)) or 'unknown target'
        logger.warning 'Login required for ' + destination, [next]
        $location.path '/'

  init = ->
    checkLogin()

  init()
  return

RouteConfig.$inject = ['$location', '$rootScope', 'authService', 'logger']
angular
  .module 'app.core'
  .run RouteConfig
