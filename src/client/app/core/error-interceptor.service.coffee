ErrorInterceptor = ($location, $q, logger) ->
  responseError: (rejection) ->
    logger.warning "error with status #{rejection.status} " +
        "and message: #{rejection.data}"

    if rejection.status is 401
      $location.path '/'
      return

    $q.reject rejection

ErrorInterceptor.$inject = ['$location', '$q', 'logger']

angular
  .module 'app.core'
  .factory 'ErrorInterceptor', ErrorInterceptor

