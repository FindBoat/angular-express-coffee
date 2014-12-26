usersResource = ($resource) ->
  $resource 'api/users/:id', id: '@id',
    me:
      method: 'GET'
      params:
        id: 'me'
      isArray: false

usersResource.$inject = ['$resource']
angular
  .module 'app.core'
  .factory 'usersResource', usersResource
