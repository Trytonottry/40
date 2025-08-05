import CryptoJS from 'crypto-js';

export function encryptContainer(data, masterKey) {
  return CryptoJS.AES.encrypt(JSON.stringify(data), masterKey).toString();
}

export function decryptContainer(cipher, masterKey) {
  const bytes = CryptoJS.AES.decrypt(cipher, masterKey);
  return JSON.parse(bytes.toString(CryptoJS.enc.Utf8));
}
