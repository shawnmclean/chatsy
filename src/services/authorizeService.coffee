
User = require('../models/user').User
Room = require('../models/room').Room

##Default Authorization service for chatsy
class AuthorizeService

  ##Verifies the user can join the chat server
  ##@param {User} the user object
  ##@param {callback} the callback that takes a bool as parameter
  canJoinServer: (handShakeData, callback) ->
    ##set user to handshake based on params
    user = new User()
    user.userId = 1
    user.username = "shawn"
    user.status = "online"
    handShakeData.user = user
    
    ##always allow all users
    callback(null, true) if callback
    
  canJoinRoom: (handShakeData, roomId, callback) ->
    ##always allow all users
    callback(true) if callback
    
  getRoom: (roomId, callback) ->
    room = new Room()
    room.roomId = roomId
    callback room
    
exports.AuthorizeService = new AuthorizeService;