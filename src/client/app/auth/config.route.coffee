appRun = (routehelper) ->
  routehelper.configureRoutes [
    {
      url: '/'
      config:
        templateUrl: '/client/app/auth/signup.jade'
        controller: 'signupController'
        controllerAs: 'vm'
        title: 'Signup'
    }
    {
      url: '/login'
      config:
        templateUrl: '/client/app/auth/login.jade'
        controller: 'loginController'
        controllerAs: 'vm'
        title: 'Login'
    }
  ]

appRun.$inject = ['routehelper']

angular
  .module 'app.auth'
  .run appRun


