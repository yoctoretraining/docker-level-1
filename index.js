'use strict';

// Dependencies
var app         = require('express')();
var request     = require('request');
var chalk       = require('chalk');
var os          = require('os');
var moment      = require('moment');

// config vars
var mode        = process.env.APP_MODE || 'ping';
var port        = 3000;
var host        = 'http://pong-local';
var interval    = null;
var delay       = 5000;

// Catch default / route to process a reponse
app.get('/', function (req, res) {
  // log a message
  console.log([ 'Receive a ping request from [', chalk.blue(req.ip), ']'].join(' '));
  // process reponse
  res.send('OK at ' + moment().format('DD/MM/YYYY hh:mm:ss'));
});

// Main callback to send request on pong server
function processRequest () {
  // process request
  request.get([ host, port ].join(':'), function (err, response, body) {
    // has any error ?
    if (err) {
      // log error
      console.log([ 'Cannot connect on host, retry with default interval will continue =>',
        err ].join(' '));
      // interval is null ?
      if (interval === null) {
        // log retry start
        console.log('Pong is not available try to reconnect');
        // process interval to check status
        interval = setInterval(processRequest, delay);
      }
    } else {
      // log reponse
      console.log([ 'Received Reponse [', chalk.green(body), '] from pong server' ].join(' '));
      // clear first interval
      clearInterval(interval);
      // process a timeout to send default process for human reading
      var timeout = setTimeout(function () {
        // clear tiemout
        clearTimeout(timeout);
        // process request
        processRequest();
      }, delay);
    }
  });
}

// is mong mode ?
if (mode === 'pong') {
  // wait and listen default port
  app.listen(port, function () {
    // log message
    console.log([ 'App [', chalk.green(mode), '] started and waiting request on port [',
      chalk.yellow(port), ']' ].join(' '));
  });
} else {
  // start interval to check connection
  console.log([ 'App [', chalk.green(mode), '] started and sending request on pong server on [',
    chalk.yellow(host), ']' ].join(' '));
  // process interval
  interval = setInterval(processRequest, delay);
}

