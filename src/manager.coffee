authService = require('./services/authorizeService').AuthorizeService


class Manager
  
  ##global list of users online
  users: []
  
  ##global list of currently active rooms
  rooms: []
  
  #authService: null
  constructor: (@io, @options) ->
    console.log authService
    ##set auth service to one specified by user else use default
    @authService = @options.AuthorizeService || authService
    
    io = @io
    self = @
    ##configure authentication
    io.configure ->
      io.of("/chat").authorization((handshakeData, callback) ->
        self.authService.canJoinServer handshakeData, callback
      ).on "connection", (socket) ->
        socket.on 'joinRoom', (data) ->
          self.joinRoom data, this
    
  ##called when a user requests to join a room
  joinRoom: (data, socket) ->
    @authService.canJoinRoom socket.handshake, data.roomId, (canJoin) ->
      if canJoin
        socket.emit "roomJoined",
          roomId: data.roomId
    
##expose the Manager class
exports = module.exports = Manager    