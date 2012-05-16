var express = require('express')
, app = express.createServer()
, io = require('socket.io').listen(app)
, chatsy = require('../../lib/chatsy').start(io, null);


app.configure(function () {
	  app.use(express.static(__dirname + '/public'));
	  app.set('views', __dirname);
	  app.set('view engine', 'jade');
});

/**
 * App routes.
 */

app.get('/', function (req, res) {
  res.render('index', { layout: false });
});
/**
 * App listen.
 */

app.listen(3000, function () {
  var addr = app.address();
  console.log('   app listening on http://' + addr.address + ':' + addr.port);
});