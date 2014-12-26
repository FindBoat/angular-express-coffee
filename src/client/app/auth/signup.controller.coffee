signupController = ($location, authService, logger) ->
  vm = this
  init = () ->
    vm.signup = {}
    vm.submitSignupForm = submitSignupForm


  submitSignupForm = ->
    authService.signup(vm.signup).then(
      (res) ->
        logger.success 'Signup success'
    , (error) ->
        logger.error 'Signup error'
    )
    
  init()
  return


signupController.$inject = ['$location', 'authService', 'logger']

angular
  .module 'app.auth'
  .controller 'signupController', signupController
  
