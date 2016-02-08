class Svg
  constructor: (selector, aspectRatio, @margin) ->
    [w, h] = aspectRatio.split(":")
    @aspectRatio = [parseInt(w), parseInt(h)]

    @domElement = document.querySelector(selector)
    @container = d3
      .select(@domElement)
      .append("svg")
      .attr('preserveAspectRatio','xMinYMin')

    @chart = @container.
      append("g")
      .attr("transform", "translate(#{@margin.left},#{@margin.top})")

   resize: () ->
    [w, h] = [@domElement.offsetWidth, @domElement.offsetHeight]
    newHeight = w / @aspectRatio[0] * @aspectRatio[1]
    margin = @margin
    @width = w - margin.left - margin.right
    @height = newHeight - margin.bottom - margin.top

    @container
      .attr("width", w)
      .attr("height", newHeight)
