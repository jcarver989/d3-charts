# D3 Charts

Easy, reusable charts built on d3.js. All of the power, none of the complexity.

## Getting Started

```html
    <!doctype html>
    <html>
      <head>
        <script src="bower_components/d3/d3.min.js"></script>
        <link rel="stylesheet" type="text/css" href="src/css/defaults.css">

        <style>
          .line1.line {
            stroke: #00aadd;
          }

          .line1.area, .line1.dot {
            fill: #00aadd;
          }

          .line2.line  {
            stroke: #33cccc;
          }

          .line2.area, .line2.dot {
            fill: #33cccc;
          }

          div {
            height: 500px;
          }
        </style>

      </head>
      <body>
        <div id="chart"></div>
        <div id="chart2"></div>

        <script src="dist/defaults.js"></script>
        <script src="dist/svg.js"></script>
        <script src="dist/abstract_chart.js"></script>
        <script src="dist/line_chart.js"></script>
        <script src="dist/scatterplot.js"></script>
        <script>
          var data1 = [
            ["Jan 1, 2014", 10],
            ["Jan 2, 2014", 20],
            ["Jan 3, 2014", 30],
            ["Jan 4, 2014", 10],
            ["Jan 5, 2014", 5],
            ["Jan 6, 2014", 30],
            ["Jan 7, 2014", 35],
            ["Jan 8, 2014", 40]
            ].map(function (d) { 
              return [
                new Date(d[0]), 
                d[1]
              ] 
            })

            chart = new LineChart("#chart", {
              xScale: d3.time.scale(),
              area: false,
              dots: true
            })

            chart.xAxis
            .ticks(d3.time.days)
            .tickFormat(d3.time.format("%Y-%m-%d"))

          chart.draw([ 
            { label: "line1", data: data1 }, 
            { label: "line2", data: data2  }
          ])
        </script>
      </body>
    </html>
```
