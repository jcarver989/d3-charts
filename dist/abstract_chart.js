// Generated by CoffeeScript 1.10.0
var AbstractChart;

AbstractChart = (function() {
  function AbstractChart(selector, options) {
    var key, opts, ref, val;
    if (options == null) {
      options = {};
    }
    opts = {};
    for (key in defaultOptions) {
      val = defaultOptions[key];
      opts[key] = defaultOptions[key];
    }
    for (key in options) {
      val = options[key];
      opts[key] = options[key];
    }
    this.options = opts;
    ref = createSvg(d3, selector, this.options.margin), this.svg = ref[0], this.width = ref[1], this.height = ref[2];
    this.x = opts.xScale.range([0, this.width]);
    this.y = opts.yScale.range([this.height, 0]);
    this.xAxis = d3.svg.axis().scale(this.x).orient("bottom").tickPadding(20);
    this.yAxis = d3.svg.axis().scale(this.y).orient("left").tickPadding(20);
    if (opts.grid) {
      this.xAxis.tickSize(-this.height);
      this.yAxis.tickSize(-this.width);
    }
    this.xAxisSelection = this.svg.append("g").attr("class", "x axis").attr("transform", "translate(0," + this.height + ")");
    this.yAxisSelection = this.svg.append("g").attr("class", "y axis");
  }

  AbstractChart.prototype.drawAxes = function() {
    this.xAxisSelection.call(this.xAxis);
    return this.yAxisSelection.call(this.yAxis);
  };

  return AbstractChart;

})();
