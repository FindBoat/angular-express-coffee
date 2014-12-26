mongoose = require 'mongoose'


Post = new mongoose.Schema
  userId: mongoose.Schema.ObjectId
  title: String
  body: String

module.exports = mongoose.model 'Post', Post
