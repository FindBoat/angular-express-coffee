bcrypt = require 'bcrypt-nodejs'
mongoose = require 'mongoose'

User = new mongoose.Schema(
  email: { type: String, unique: true, lowercase: true },
  password: String,

  profile: {
    name: { type: String, default: '' },
    gender: { type: String, default: '' },
    location: { type: String, default: '' },
    website: { type: String, default: '' },
    picture: { type: String, default: '' }
  }
)


User.pre 'save', (next) ->
  user = this
  if not user.isModified 'password' then return next()

  bcrypt.genSalt 5, (err, salt) ->
    if err? then return next err

    bcrypt.hash user.password, salt, null, (err, hash) ->
      if err? then return next err
      user.password = hash
      next()


User.methods.comparePassword = (candidatePassword, cb) ->
  bcrypt.compare candidatePassword, this.password, (err, isMatch) ->
    if err? then return cb err
    cb null, isMatch

  
module.exports = mongoose.model 'User', User
