##Default Authorization service for chatsy
class AuthorizeService

  ##Verifies the user can join the chat server
  ##@param {User} the user object
  ##@param {callback} the callback that takes a bool as parameter
  canJoinServer: (user, callback) ->
    ##always allow all users
    callback(true) if callback
    
  canJoinRoom: (user, room, callback) ->
    ##always allow all users
    callback(true) if callback
