options_timeline = {
  title: { text: 'Players Position' },
  xAxis: {
  },
  yAxis: { 
    title: { text: 'Scores'  }, 
    min: 0 },
  #tooltip: {
  #     formatter: ->
  #       Highcharts.dateFormat("%d %B", @x) + ': ' + Highcharts.numberFormat(@y, 0)
  #},
  plotOptions: {
    bar: {
      pointPadding: 0.2,
      borderWidth: 0
    }
  },
  series: <%= raw @play.data %>
}

$("#timeline_chart").highcharts(options_timeline)