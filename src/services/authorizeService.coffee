

##Default Authorization service for chatsy
class AuthorizeService

  ##Verifies the user can join the chat server
  ##@param {User} the user object
  ##@param {callback} the callback that takes a bool as parameter
  canJoinServer: (handShakeData, callback) ->
    ##always allow all users
    callback(null, true) if callback
    
  canJoinRoom: (handShakeData, roomId, callback) ->
    ##always allow all users
    callback(true) if callback
    
exports.AuthorizeService = new AuthorizeService;