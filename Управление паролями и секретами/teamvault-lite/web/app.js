const token = localStorage.getItem('token');
async function api(path, body) {
  return fetch('/api/vault' + path, {
    method: body ? 'POST' : 'GET',
    headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
    body: body ? JSON.stringify(body) : undefined
  }).then(r => r.json());
}

document.getElementById('addForm').addEventListener('submit', async e => {
  e.preventDefault();
  const [name, username, password, uri] = [...e.target.elements].map(el => el.value);
  await api('', { name, username, password, uri });
  location.reload();
});

(async () => {
  const items = await api('/');
  const ul = document.getElementById('list');
  items.forEach(i => {
    const li = document.createElement('li');
    li.textContent = `${i.name} (${i.data.username})`;
    ul.appendChild(li);
  });
})();
