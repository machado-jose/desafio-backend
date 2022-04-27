import Chart from 'chart.js/auto'

document.addEventListener('turbolinks:load', () => {
  var ctx = document.getElementById('myChart').getContext('2d');
  var myChart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: JSON.parse(ctx.canvas.dataset.labels),
    datasets: [{
      data: JSON.parse(ctx.canvas.dataset.data),
      backgroundColor: "rgba(0, 123, 255, 0.6)",
      borderColor: 'rgb(0, 123, 255)',
      borderWidth: 1
    }]
  },
  options: {
    scales: {
      y: {
        ticks: {
          callback: function(value, index, ticks) {
            return 'R$ ' + value + ',00';
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
