import L from 'leaflet';
import { City } from './city.js';

const map = L.map('map').setView([30, 0], 2);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  attribution: '© OSM'
}).addTo(map);

let cities = [];

async function load() {
  cities = (await window.api.getCities()).map(c => new City(c));
  drawCities();
}

function drawCities() {
  cities.forEach(city => {
    const circle = L.circle([city.lat, city.lng], {
      color: city.color,
      fillColor: city.color,
      fillOpacity: 0.6,
      radius: city.radius * 1000 // км в метры
    }).addTo(map);

    circle.bindPopup(`
      <b>${city.name}</b><br>
      Last changed: ${new Date(city.lastChanged).toLocaleDateString()}<br>
      <button onclick="editCity('${city.id}')">Capture city</button>
    `);
  });
}

window.editCity = async (id) => {
  const city = cities.find(c => c.id === id);
  const newPwd = prompt(`New password for ${city.name}:`, city.password);
  if (newPwd) {
    city.updatePassword(newPwd);
    await window.api.saveCities(cities.map(c => ({ ...c })));
    map.eachLayer(l => l instanceof L.Circle && map.removeLayer(l));
    drawCities();
  }
};

load();
