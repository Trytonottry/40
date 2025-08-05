#!/usr/bin/env node
import { Command } from 'commander';
import fs from 'fs';
import { encryptContainer } from '../backend/src/crypto.js';
import { uploadEncrypted } from '../backend/src/ipfs.js';
import { armSwitch } from '../backend/src/contract.js';

const program = new Command();
program
  .name('secret-flight')
  .description('CLI to arm dead-man switch')
  .requiredOption('-f, --file <path>', 'JSON file with secrets')
  .requiredOption('-k, --key <masterKey>', 'master password')
  .option('-r, --recipients <addrs>', 'comma-separated ETH addresses')
  .option('-d, --days <n>', 'grace days', '30')
  .action(async (opts) => {
    const data = fs.readFileSync(opts.file, 'utf8');
    const cipher = encryptContainer(JSON.parse(data), opts.key);
    const cid = await uploadEncrypted(cipher);
    const recipients = opts.recipients.split(',');
    await armSwitch(recipients, cid, opts.days);
    console.log('Armed! IPFS CID:', cid);
  });

program.parse();
