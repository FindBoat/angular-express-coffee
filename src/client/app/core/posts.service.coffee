postsResource = ($resource) ->
  $resource 'api/users/me/posts/:id', id: '@id'

postsResource.$inject = ['$resource']
angular
  .module 'app.core'
  .factory 'postsResource', postsResource
