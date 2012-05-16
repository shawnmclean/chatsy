
class Manager
  
  ##global list of users online
  users: []
  
  ##global list of currently active rooms
  rooms: []
  
  constructor: (@io, @options) ->
    self = @this
    ##joining the room
    @io.sockets.on 'connection', (socket) ->
      socket.on 'joinRoom', self.joinRoom
  
  ##called when a user requests to join a room
  joinRoom: (data) ->

##expose the Manager class
exports = module.exports = Manager    