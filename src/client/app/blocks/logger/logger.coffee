logger = ($log) ->
  error = (message, data, title) ->
    $log.error 'Error: ' + message, data

  info = (message, data, title) ->
    $log.info 'Info: ' + message, data

  success = (message, data, title) ->
    $log.info 'Success: ' + message, data

  warning = (message, data, title) ->
    $log.warn 'Warning: ' + message, data

  service =
    error: error
    info: info
    success: success
    warning: warning
    log: $log.log
  return service


logger.$inject = ['$log']
angular
  .module 'blocks.logger'
  .factory 'logger', logger


