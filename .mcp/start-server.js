// Mock MCP Server for testing purposes
// Replace with actual @modelcontextprotocol/server-azure when available

const http = require('http');
const config = require('./config.json');

async function startServer() {
  const server = http.createServer((req, res) => {
    if (req.url === '/health') {
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ status: 'healthy' }));
    } else {
      res.writeHead(404);
      res.end();
    }
  });
  
  server.listen(config.server.port, config.server.host, () => {
    console.log('[OK] Azure MCP Server is ready');
    console.log(`Server running at http://${config.server.host}:${config.server.port}`);
  });
  
  server.on('error', (error) => {
    console.error('[ERROR] MCP Server error:', error);
  });
}

startServer().catch(console.error);
