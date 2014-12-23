Post = require '../models/post'

module.exports =
  getAll: (req, res) ->
    Post.find {}, (err, posts) ->
      res.send posts

  create: (req, res) ->
    post = new Post req.body
    post.save (err, post) ->
      if not err
        res.send post
        res.statusCode = 201
      else
        res.send err
        res.statusCode = 500

        
  
