import { Router } from 'express';
import CryptoJS from 'crypto-js';
import { db } from './db.js';
import jwt from 'jsonwebtoken';

export const router = Router();

function auth(req, res, next) {
  const token = req.headers.authorization?.split(' ')[1];
  try {
    req.user = jwt.verify(token, process.env.JWT_SECRET);
    next();
  } catch {
    res.status(401).json({ error: 'Unauthorized' });
  }
}

router.get('/', auth, (req, res) => {
  const rows = db.prepare('SELECT * FROM items WHERE user_id=?').all(req.user.id);
  res.json(rows.map(r => ({ ...r, data: decrypt(r.data) })));
});

router.post('/', auth, (req, res) => {
  const { name, username, password, uri } = req.body;
  const cipher = encrypt(JSON.stringify({ username, password, uri }));
  const info = db
    .prepare('INSERT INTO items (user_id, name, data) VALUES (?, ?, ?)')
    .run(req.user.id, name, cipher);
  res.json({ id: info.lastInsertRowid });
});

function encrypt(obj) {
  return CryptoJS.AES.encrypt(JSON.stringify(obj), process.env.JWT_SECRET).toString();
}
function decrypt(cipher) {
  const bytes = CryptoJS.AES.decrypt(cipher, process.env.JWT_SECRET);
  return JSON.parse(bytes.toString(CryptoJS.enc.Utf8));
}
