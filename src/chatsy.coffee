
exports.Manager = require('./manager')

exports.chatsy = (socket, options) ->
  new exports.Manager(socket, options)
