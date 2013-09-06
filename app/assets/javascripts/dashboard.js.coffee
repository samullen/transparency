$ ->
  new Morris.Donut({
    element: "project-percentages",
    data: percentages_data,
    colors: ["#5c1010", "#8d3030", "#c67e7e", "#666666", "#cccccc", "#eeeeee"],
  })

  new Morris.Line {
    element: "daily_hours",
    data: hour_data,
    xkey: 'y',
    ykeys: ykeys,
    labels: ykeys,
    hideHover: true
    lineColors: [
      "#5c1010", "#8d3030", "#c67e7e", "#666666", "#cccccc", "#eeeeee"
    ],
  }

