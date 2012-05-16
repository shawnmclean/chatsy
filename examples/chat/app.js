var app = require('express').createServer()
, io = require('socket.io').listen(app)
, chatsy = require('../../lib/chatsy').start(io, null);
app.get('/', function(req, res){
  res.send('hello world');
});

app.listen(3000);