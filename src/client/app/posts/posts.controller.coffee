postsController = ($route, logger, posts, postsResource) ->
  vm = this
  init = () ->
    vm.post = {}
    vm.posts = posts
    vm.submitPostForm = submitPostForm


  submitPostForm = ->
    postsResource.save vm.post
    , (post) ->
      $route.reload()
    , (error) ->
      logger.warning 'Create post fail', error

  init()
  return


postsController.$inject = ['$route', 'logger', 'posts', 'postsResource']
angular
  .module 'app.posts'
  .controller 'postsController', postsController
