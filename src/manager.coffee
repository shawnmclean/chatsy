authService = require('./services/authorizeService').AuthorizeService


class Manager
  
  ##global list of users online
  users: []
  
  ##global list of currently active rooms
  rooms: []
  
  #authService: null
  constructor: (@io, @options) ->
    ##set auth service to one specified by user else use default
    @authService = @options.AuthorizeService || authService
    
    io = @io
    self = @
    ##configure authentication
    io.configure ->
      io.of("/chat").authorization((handshakeData, callback) ->
        self.authService.canJoinServer handshakeData, callback
      ).on "connection", (socket) ->
        ##throw exception if the user in handshake was not set (should be set from auth service)
        throw "user object was not set on handshake during canJoinServer auth call"  unless socket.handshake.user?
        socket.on 'joinRoom', (data) ->
          self.joinRoom data, this
    
  ##called when a user requests to join a room
  joinRoom: (data, socket) ->
    self = @
    ##validate if user can join the room
    @authService.canJoinRoom socket.handshake, data.roomId, (canJoin) ->
      if canJoin
        ##find the room in current list
        room = self.rooms.filter((el) ->
          el.roomId == data.roomId
        )[0]
        
        ##if not in list, pull it down from the auth service and add it
        unless room?
          self.authService.getRoom data.roomId, (room) ->
            
            ##add user to room
            room.users.push socket.handshake.user       
            
            ##add room to list
            self.rooms.push room
                        
            ##alert the client that the room has been joined
            socket.emit "roomJoined",
              room: room
        else
          room.users.push socket.handshake.user
          
          ##alert the client that the room has been joined
          socket.emit "roomJoined",
            room: room
          
##expose the Manager class
exports = module.exports = Manager    