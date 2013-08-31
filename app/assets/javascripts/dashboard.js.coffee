$ ->
  new Morris.Donut({
    element: 'pie_chart',
    data: [
      { label: '2008', value: 20 },
      { label: '2009', value: 10 },
      { label: '2010', value: 5 },
      { label: '2011', value: 5 },
      { label: '2012', value: 20 }
    ],
  })

  new Morris.Area {
    element: 'area_chart',
    data: [
      { y: '2006', a: 100, b: 90 },
      { y: '2007', a: 75,  b: 65 },
      { y: '2008', a: 50,  b: 40 },
      { y: '2009', a: 75,  b: 65 },
      { y: '2010', a: 50,  b: 40 },
      { y: '2011', a: 75,  b: 65 },
      { y: '2012', a: 100, b: 90 }
    ],
    xkey: 'y',
    ykeys: ['a', 'b'],
    labels: ['Series A', 'Series B']
  }

