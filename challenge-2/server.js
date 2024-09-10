const http = require('http');
const fs = require('fs');
const path = require('path');

const port = 3300;

const requestListener = (req, res) => {
    if (req.url === '/') {
        fs.readFile(path.join(__dirname, 'index.html'), 'utf8', (err, data) => {
            if (err) {
                res.writeHead(500);
                res.end('Error reading file');
                return;
            }
            res.writeHead(200, { 'Content-Type': 'text/html' });
            res.end(data);
        });
    } else {
        res.writeHead(404);
        res.end('Not Found');
    }
};

const server = http.createServer(requestListener);

server.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
