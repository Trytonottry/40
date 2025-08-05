import CryptoJS from 'crypto-js';
import zxcvbn from 'zxcvbn';

export async function encryptVault(plain, master) {
  return CryptoJS.AES.encrypt(plain, master).toString();
}

export async function decryptVault(cipher, master) {
  const bytes = CryptoJS.AES.decrypt(cipher, master);
  return bytes.toString(CryptoJS.enc.Utf8);
}

export function entropy(password) {
  return zxcvbn(password).guesses_log10;
}
