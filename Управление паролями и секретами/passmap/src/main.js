import { app, BrowserWindow, ipcMain, dialog } from 'electron';
import Store from 'electron-store';
import path from 'path';

const store = new Store();
let win;

function createWindow() {
  win = new BrowserWindow({
    width: 1200,
    height: 800,
    webPreferences: {
      preload: path.join(import.meta.dirname, 'preload.js'),
      contextIsolation: true
    }
  });
  win.loadFile('src/renderer/index.html');
}

app.whenReady().then(createWindow);

// IPC-хендлеры
ipcMain.handle('getCities', () => store.get('cities', []));
ipcMain.handle('saveCities', (_, cities) => store.set('cities', cities));
ipcMain.handle('encrypt', (_, plain, master) => {
  const CryptoJS = (await import('crypto-js')).default;
  return CryptoJS.AES.encrypt(plain, master).toString();
});
ipcMain.handle('decrypt', (_, cipher, master) => {
  const CryptoJS = (await import('crypto-js')).default;
  const bytes = CryptoJS.AES.decrypt(cipher, master);
  return bytes.toString(CryptoJS.enc.Utf8);
});
ipcMain.handle('showOpenDialog', () => dialog.showOpenDialog(win, { properties: ['openFile'] }));
