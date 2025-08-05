import { entropy } from './vault.js';

export class City {
  constructor({ id, name, lat, lng, password, lastChanged }) {
    this.id = id || crypto.randomUUID();
    this.name = name;
    this.lat = lat;
    this.lng = lng;
    this.password = password;
    this.lastChanged = lastChanged || Date.now();
  }

  get radius() {
    // 1.5 px на каждую единицу энтропии
    return Math.max(5, entropy(this.password) * 1.5);
  }

  get color() {
    const age = Date.now() - this.lastChanged;
    const days = age / (1000 * 60 * 60 * 24);
    if (days < 30) return '#4caf50';
    if (days < 90) return '#ff9800';
    return '#f44336';
  }

  updatePassword(pwd) {
    this.password = pwd;
    this.lastChanged = Date.now();
  }
}
