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
        
        ##add the user to list of users
        #self.users.push socket.handshake.user
        
        socket.on 'joinRoom', (data) ->
          self.joinRoom data, this
        socket.on 'disconnect', () ->
          self.disconnected this
    
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
            self.setupJoinRoom(room, socket)
        else        
          self.setupJoinRoom(room, socket)
          

  disconnected: (socket) ->
    ##find all rooms the user is in and remove them.
    for room in socket.handshake.user.rooms
      room = @rooms.filter((el)->
        el.roomId == room.roomId
      )[0]
      ##remove the user from the room
      room.users = room.users.filter((el) ->
        el.userId != socket.handshake.user.userId
      )

  setupJoinRoom: (room, socket) ->
    ##add the room to the user
    socket.handshake.user.rooms.push room
            
    ##add user to room
    room.users.push socket.handshake.user       
            
    ##add room to list
    @rooms.push room
                        
    ##alert the client that the room has been joined
    socket.emit "roomJoined",
      room: room.roomId

##expose the Manager class
exports = module.exports = Manager    