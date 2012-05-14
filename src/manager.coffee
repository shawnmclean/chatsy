
class Manager
  
  ##global list of users online
  users: []
  
  ##global list of currently active rooms
  rooms: []
  
  constructor: (@socket, @options) ->
  