## represents a user of the system
class User
  constructor: (@userId = 0, @username ='', @status = 'online', @rooms = []) ->

exports.User = User