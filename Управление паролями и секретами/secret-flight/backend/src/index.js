import express from 'express';
import cron from 'node-cron';
import dotenv from 'dotenv';
import { pingAlive, triggerIfDead } from './contract.js';

dotenv.config();
const app = express();
app.use(express.json());

// Ручка «я жив» (можно дергать cURL либо cron-ом на ПК)
app.post('/ping', async (_, res) => {
  await pingAlive();
  res.json({ ok: true });
});

// Фоновая задача проверки dead-man
cron.schedule('0 0 * * *', async () => {
  console.log('Checking dead-man switch...');
  await triggerIfDead();
});

app.listen(process.env.PORT, () =>
  console.log(`Secret-Flight backend on :${process.env.PORT}`)
);
