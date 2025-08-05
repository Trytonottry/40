import Chart from 'https://cdn.jsdelivr.net/npm/chart.js';

fetch('/dashboard/acme')
  .then(r => r.json())
  .then(data => {
    new Chart(document.getElementById('heatMap'), {
      type: 'bar',
      data: {
        labels: data.map(d => d.dept),
        datasets: [{ label: 'clicks', data: data.map(d => d.clicks) }]
      }
    });
  });