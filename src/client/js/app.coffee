angular.module 'myApp', [
  'ngRoute'
  'ngResource'
]

.config [
  '$routeProvider'
  ($routeProvider) ->
    $routeProvider.when '/',
      templateUrl: 'partials/index'
      controller: 'IndexController'
]
