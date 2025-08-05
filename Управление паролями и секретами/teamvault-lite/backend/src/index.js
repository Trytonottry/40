import express from 'express';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { router as auth } from './auth.js';
import { router as vault } from './vault.js';
import { auditAll } from './audit.js';

const app = express();
app.use(express.json());
app.use('/api/auth', auth);
app.use('/api/vault', vault);

const server = createServer(app);
const wss = new WebSocketServer({ server });

wss.on('connection', ws => {
  ws.on('message', async () => {
    const report = await auditAll();
    ws.send(JSON.stringify({ type: 'audit', report }));
  });
});

server.listen(process.env.PORT || 3000, () =>
  console.log(`TeamVault on :${process.env.PORT || 3000}`)
);
