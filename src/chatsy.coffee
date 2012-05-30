
exports.Manager = require('./manager')
exports.User = require('./models/user').User

exports.start = (io, options) ->
  new exports.Manager(io, options)
