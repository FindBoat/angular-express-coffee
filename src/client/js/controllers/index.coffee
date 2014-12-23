angular.module 'myApp'

.controller 'IndexController', [
  '$scope'
  'postsResource'
  ($scope, postsResource) ->
    postsResource.query (posts) ->
      $scope.posts = posts
    return
]
