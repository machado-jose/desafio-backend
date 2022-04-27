import Chart from 'chart.js/auto'

document.addEventListener('turbolinks:load', () => {
  var ctx = document.getElementById('myChart').getContext('2d');
  var myChart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: JSON.parse(ctx.canvas.dataset.labels),
    datasets: [{
      data: JSON.parse(ctx.canvas.dataset.data),
    }]
  },
  options: {
    scales: {
      y: {
        ticks: {
          callback: function(value, index, ticks) {
            return 'R$ ' + value;
          }
        }
      }
    },
    plugins: {
      legend: {
        display: false
      },
      tooltip: {
        callbacks: {
          label: function(tooltipItem) {
            return "R$ " + tooltipItem.formattedValue;
          }
        }
      }
    }
  }
  });
})

