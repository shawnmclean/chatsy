
exports.Manager = require('./manager')

exports.start = (socket, options) ->
  new exports.Manager(socket, options)
