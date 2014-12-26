# routehelperConfig.
routehelperConfig = ->
  this.config = {
    # These are the properties we need to set
    # $routeProvider: undefined
    # docTitle: ''
    # loginRequired: false
    # resolveAlways: { ready: function(){ } }
  }

  this.$get = -> config: this.config
  return


# routehelper.
routehelper = (
  $location,
  $rootScope,
  $route,
  logger,
  routehelperConfig
) ->
  routeCounts = errors: 0, changes: 0
  routes = []
  $routeProvider = routehelperConfig.config.$routeProvider

  configureRoutes = (routes) ->
    for route in routes
      route.config.resolve = angular.extend(
        route.config.resolve or {}, routehelperConfig.config.resolveAlways)
      $routeProvider.when route.url, route.config

    $routeProvider.otherwise redirectTo: '/'

  getRoutes = ->
    for prop in $route.routes
      if $route.routes.hasOwnProperty prop
        route = $route.routes[prop]
        if route.title? then routes.push route
    return routes

  handleRoutingErrors = ->
    $rootScope.$on '$routeChangeError', (event, current, previous, rejection) ->
      routeCounts.errors++
      destination = (current and (current.title or current.name or
          current.loadedTemplateUrl)) or 'unknown target'
      msg = 'Error routing to ' + destination + '. ' + (rejection.msg or '')
      logger.warning msg, [current]
      $location.path '/'

  updateDocTitle = ->
    $rootScope.$on '$routeChangeSuccess', (event, current, previous) ->
      routeCounts.changes++
      title = routehelperConfig.config.docTitle + ' ' + (current.title or '')
      $rootScope.title = title

  init = ->
    handleRoutingErrors()
    updateDocTitle()

  init()
  service =
    configureRoutes: configureRoutes
    getRoutes: getRoutes
    routeCounts: routeCounts
  return service

  
routehelper.$inject = [
  '$location'
  '$rootScope'
  '$route'
  'logger'
  'routehelperConfig'
]
  
angular
  .module 'blocks.router'
  .provider 'routehelperConfig', routehelperConfig
  .factory 'routehelper', routehelper

