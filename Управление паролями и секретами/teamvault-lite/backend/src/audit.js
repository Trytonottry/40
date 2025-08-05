import fetch from 'node-fetch';
import crypto from 'crypto';
import { db } from './db.js';

export async function auditAll() {
  const rows = db.prepare('SELECT id, data FROM items').all();
  const report = [];
  for (const r of rows) {
    const { password } = JSON.parse(r.data);
    const sha1 = crypto.createHash('sha1').update(password).digest('hex').toUpperCase();
    const prefix = sha1.slice(0, 5);
    const suffix = sha1.slice(5);
    const res = await fetch(`https://api.pwnedpasswords.com/range/${prefix}`);
    const text = await res.text();
    const found = text.split('\n').some(l => l.startsWith(suffix));
    report.push({ id: r.id, pwned: found });
  }
  return report;
}
