'use strict';

var app     = require('express')();
var request = require('request');
var chalk   = require('chalk');
var os      = require('os');
var moment  = require('moment');

var mode = process.env.APP_MODE || 'ping';
var port = 3000;
var host = 'http://pong-local';
var interval = null;
var delay = 5000;

app.get('/', function (req, res) {
  console.log([ 'Receive a ping request from [', chalk.blue(req.ip), ']'].join(' '));
  res.send('OK at ' + moment().format('DD/MM/YYYY hh:mm:ss'));
});

function processRequest () {
  request.get([ host, port ].join(':'), function (err, response, body) {
    if (err) {
      console.log([ 'Cannot connect on host, retry with default interval will continue =>', err ].join(' '));
      if (interval === null) {
       console.log('Pong is not available try to reconnect');
       interval = setInterval(processRequest, delay);
      }
    } else {
      console.log([ 'Received Reponse [', chalk.green(body), '] from pong server' ].join(' '));
      clearInterval(interval);
      var timeout = setTimeout(function () {
       clearTimeout(timeout);
       processRequest();
      }, delay);
    }
  });
}

if (mode === 'pong') {
 app.listen(port, function () {
  console.log([ 'App [', chalk.green(mode), '] started and waiting request on port [', chalk.yellow(port), ']' ].join(' '));
 });
} else {
 console.log([ 'App [', chalk.green(mode), '] started and sending request on pong server on [', chalk.yellow(host), ']' ].join(' '));
 interval = setInterval(processRequest, delay);
}

