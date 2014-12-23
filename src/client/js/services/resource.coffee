angular.module 'myApp'

.factory 'postsResource', [
  '$resource'
  ($resource) ->
    $resource 'api/posts'
]
