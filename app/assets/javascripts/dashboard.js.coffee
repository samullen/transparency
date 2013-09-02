$ ->
  new Morris.Donut({
    element: "project-percentages",
    data: percentages_data,
  })

  new Morris.Line {
    element: "daily_hours",
    data: hour_data,
    xkey: 'y',
    ykeys: ykeys,
    labels: ykeys,
    hideHover: true
  }

