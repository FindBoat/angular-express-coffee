appRun = (routehelper) ->
  routehelper.configureRoutes [
    {
      url: '/posts'
      config:
        templateUrl: '/client/app/posts/posts.jade'
        controller: 'postsController'
        controllerAs: 'vm'
        title: 'Posts'
        loginRequired: true
        resolve:
          posts: ['postsResource', (posts) ->
            posts.query().$promise
          ]
    }
  ]

appRun.$inject = ['routehelper']

angular
  .module 'app.posts'
  .run appRun
