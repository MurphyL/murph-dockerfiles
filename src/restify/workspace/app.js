const http = require('http');

const { SERVE_PORT } = process.env;

http.createServer((req, res) => {
    res.writeHead(200);
    res.end('Hello, World!');
}).listen(SERVE_PORT);
