$ ->
  if project_data?
    new Morris.Line {
      element: "project-month",
      data: project_data,
      xkey: 'y',
      ykeys: ykeys,
      labels: ykeys,
      hideHover: true
      lineColors: [
        "#5c1010", "#8d3030", "#c67e7e", "#666666", "#cccccc", "#eeeeee"
      ],
    }
