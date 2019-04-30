const express = require('express');
const http2 = require('http2');
const spdy = require('spdy');
// const http = require('http');
const https =  require('https');
const fs = require('fs');
const app = express();
const options = {
    key: fs.readFileSync('/APP/SSL/localhost-privkey.pem'),
    cert: fs.readFileSync('/APP/SSL/localhost-cert.pem')
};
const port = 3000;
app.get('/',(req,res)=> res.json({message:' http2 awesome'}));
// const server = http2.createServer(options,app);

spdy
  .createServer(options, app)
  .listen(port, (error) => {
    if (error) {
      console.error(error)
      return process.exit(1)
    } else {
      console.log('Listening on port: ' + port + '.')
    }
  })