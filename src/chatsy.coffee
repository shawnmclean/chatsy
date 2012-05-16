
exports.Manager = require('./manager')

exports.start = (io, options) ->
  new exports.Manager(io, options)
