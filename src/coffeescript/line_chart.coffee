class LineChart extends AbstractChart
  constructor: (selector, options = {}) ->
    super(selector, options)

    @line = d3.svg.line()
      .interpolate("cardinal") # smoothing
      .x (d) => @x(extractX(d))
      .y (d) => @y(extractY(d))

    @area = d3.svg.area()
      .interpolate("cardinal") # smoothing
      .x (d) => @x(extractX(d))
      .y (d) => @y(extractY(d))
      .y0(@height)

  drawCircles: (lines, data, tooltips) ->
    circles = lines.selectAll("circle").data((line) ->
      data = []

      if line.dots != false
        for d in line.data
          d.label = line.label
          data.push(d)

      data
    )

    newCircles = circles.enter().append("circle")
      .attr("class", (d) -> "dot #{d.label}")
      .attr("r", 6)
      .attr("cx", (d) => @x(extractX(d)))
      .attr("cy", (d) => @y(extractY(d)))


    circles
      .attr("transform", "translate(0, #{@height})")
      .attr("opacity", 0)
      .transition()
      .duration(1000)
      .delay((d, i) => i * 100 + 1000)
      .attr("opacity", 1)
      .attr("transform", "translate(0, 0)")

    if tooltips
      tip = (@tip ||= new Tooltip(document))
      
      circles
        .on("mouseover", (d) ->
          tip.html(d[1])
          tip.show(this)
        )

        .on("mouseout", (d) ->
          tip.hide()
        )

    circles.exit().remove()

  drawLines: (enter, update) ->
    path = enter
      .append("path")
      .attr("class", (d) -> "line #{d.label}")
      .attr("d", (d) => @line(d.data))

    totalLength = path.node().getTotalLength()

    path
      .attr("stroke-dasharray", "#{totalLength} #{totalLength}")
      .attr("stroke-dashoffset", totalLength)
      .transition()
      .duration(2000)
      .attr("stroke-dashoffset", 0)

  drawAreas: (enter, update) ->
    path = enter
      .filter((d) -> d.area != false)
      .append("path")
      .attr("class", (d) -> "area #{d.label}")
      .attr("d", (d) => @area(d.data))

    path
      .style("fill-opacity", 0)
      .transition()
      .delay(800)
      .style("fill-opacity", 1)


  draw: (lines) ->
    allPoints = (line.data for line in lines)
    flattened = d3.merge(allPoints)
    @x.domain d3.extent(flattened, extractX)
    @y.domain [0, d3.max(flattened, extractY)]

    @drawAxes()

    lines = @svg
      .selectAll(".lineGroup")
      .data(lines, (d) -> d.label)
    
    newLines = lines
      .enter().append("g")
      .attr("class", "lineGroup")

    lines.exit().remove()

    @drawLines(newLines, lines)
    @drawAreas(newLines, lines) if @options.area
    @drawCircles(lines, allPoints, @options.tooltips) if @options.dots



      

