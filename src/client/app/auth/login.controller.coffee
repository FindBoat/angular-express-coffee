loginController = ($location, authService, logger) ->
  vm = this
  init = () ->
    vm.login = {}
    vm.submitLoginForm = submitLoginForm


  submitLoginForm = ->
    authService.login(vm.login).then(
      (res) ->
        logger.success 'Login success'
        $location.path '/posts'
    , (error) ->
        logger.error 'Login error'
    )
    
  init()
  return


loginController.$inject = ['$location', 'authService', 'logger']
angular
  .module 'app.auth'
  .controller 'loginController', loginController
  
