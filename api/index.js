'use strict';
// Vercel Serverless Function entry point
const { server } = require('../app/server');

module.exports = (req, res) => {
  server.emit('request', req, res);
};
