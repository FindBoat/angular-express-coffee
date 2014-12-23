var app, port;

app = require('./.app');

port = app.port;

app.listen(port, function() {
  return console.log("Listening on " + port + "\nPress CTRL-C to stop server.");
});
