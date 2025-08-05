import { contextBridge, ipcRenderer } from 'electron';

contextBridge.exposeInMainWorld('api', {
  getCities: () => ipcRenderer.invoke('getCities'),
  saveCities: (cities) => ipcRenderer.invoke('saveCities', cities),
  encrypt: (plain, master) => ipcRenderer.invoke('encrypt', plain, master),
  decrypt: (cipher, master) => ipcRenderer.invoke('decrypt', cipher, master),
  showOpenDialog: () => ipcRenderer.invoke('showOpenDialog')
});
