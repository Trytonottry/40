#!/usr/bin/env node
import { Command } from 'commander';
import fs from 'fs';
import { encryptContainer } from '../backend/src/crypto.js';

const program = new Command();
program
  .name('tv-cli')
  .description('CLI to import/export TeamVault Lite')
  .command('import <file>')
  .action(file => {
    const data = JSON.parse(fs.readFileSync(file));
    // TODO: POST /api/vault/bulk
    console.log('Imported', data.length, 'items');
  });

program.parse();
