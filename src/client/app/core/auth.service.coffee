authService = ($http, $window) ->

  user = null

  storeRes = (res) ->
    $window.localStorage.setItem 'token', res.data.token
    $window.localStorage.setItem 'user', res.data.user
    user = res.data.user
    
  signup = (req) ->
    $http.post('/api/users', req).then (res) ->
      storeRes res
  
  login = (req) ->
    $http.post('/api/auth', req).then (res) ->
      storeRes res

  logout = ->
    $window.localStorage.removeItem 'token'
    $window.localStorage.removeItem 'user'
    user = null

  currentUser = ->
    if user? then return user
    return $window.localStorage.getItem 'user'

  isLogin = -> currentUser()?

  service =
    signup: signup
    login: login
    logout: logout
    isLogin: isLogin
    currentUser: currentUser()
  return service


authService.$inject = ['$http', '$window']
angular
  .module 'app.core'
  .factory 'authService', authService

