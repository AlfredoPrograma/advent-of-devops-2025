const express = require('express');
const app = express();

// Port from environment variable
const PORT = process.env.PORT || 3000;

app.get('/health', (req, res) => {
  res.json({ status: 'healthy' });
});

app.get('/', (req, res) => {
  res.send('Hello from fixed container!');
});

const server = app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

async function shutdown() {
  const SHUTDOWN_TIMEOUT = 10_000;
  console.log('Shutting down server...');
  server.close(() => {
    console.log('Server closed.');
    process.exit(0);
  })

  setTimeout(() => {
    process.exit(1);
  }, SHUTDOWN_TIMEOUT)
}

process.on("SIGTERM", shutdown)
process.on("SIGINT", shutdown)