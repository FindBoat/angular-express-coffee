inquirer = require 'inquirer'
mongoose = require 'mongoose'
User = require '../server/models/users'
config = require '../server/config/config'


# Config environment & connect db.
env = process.env.NODE_ENV or 'dev'
config.setEnvironment env
db = mongoose.connect(
  "mongodb://#{config.DB_HOST}:#{config.DB_PORT}/#{config.DB_NAME}")


module.exports =
  getUser: ->
    questions = [
      {
        type: 'input'
        name: 'email'
        message: 'Email of the user'
      }
    ]

    inquirer.prompt questions, (answers) ->
      User.findOne email: answers.email, (err, user) ->
        if err?
          console.warn 'Fetch error: ' + err
        else if user?
          console.log user
        else
          console.log 'user not found\n'

        db.disconnect()

  getUsers: ->
    User.find (err, users) ->
      if err?
        console.warn 'Fetch error: ' + err
      else
        console.log users

      db.disconnect()
