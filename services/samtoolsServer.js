#!/usr/bin/env node

// temporary until i understand why freebayes seg faults on the stream
process.on('uncaughtException', function (exception) {
   // handle or ignore error
});

var minion = require('../minion'),
    http = require('http'),
    app = minion(),
    server = http.createServer(app),
    port = 8060;
    
// process command line options
process.argv.forEach(function (val, index, array) {
  if(val == '--port' && array[index+1]) port = array[index+1];
});

// setup socket
var io = require('socket.io').listen(server);

// start server
server.listen(port);

// define tool
var tool = {
   apiVersion : "0.1",
   name : 'samtools',   
   path: 'samtools',
   args: ['-'],
   binary: true,
   // instructional data used in /help
   description : 'utility for manipulating sam formate files',
   exampleUrl : ""
};

// add tool to minion server
minion.addTool(tool);

// start minion socket
minion.listen(io);
