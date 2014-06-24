// Generated by CoffeeScript 1.7.1
var Tooltip,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Tooltip = (function() {
  function Tooltip(doc) {
    this.hide = __bind(this.hide, this);
    this.show = __bind(this.show, this);
    this.html = __bind(this.html, this);
    this.tip = d3.select(doc.createElement('div'));
    this.tip.attr("class", "d3-tip");
    doc.body.appendChild(this.tip.node());
  }

  Tooltip.prototype.html = function(content) {
    return this.tip.html(content);
  };

  Tooltip.prototype.show = function(node) {
    var offset;
    offset = this.offset(node);
    this.tip.attr("class", "d3-tip show");
    return this.tip.style({
      "position": "absolute",
      "top": "" + offset.top + "px",
      "left": "" + offset.left + "px"
    });
  };

  Tooltip.prototype.hide = function() {
    return this.tip.attr("class", "d3-tip");
  };

  Tooltip.prototype.offset = function(node) {
    var nodeCenter, nodeCoords, scrollX, scrollY, tipCoords, tipHeight, tipWidth;
    nodeCoords = node.getBoundingClientRect();
    nodeCenter = nodeCoords.left + ((nodeCoords.right - nodeCoords.left) / 2);
    tipCoords = this.tip.node().getBoundingClientRect();
    tipWidth = tipCoords.right - tipCoords.left;
    tipHeight = tipCoords.bottom - tipCoords.top;
    scrollX = window.scrollX;
    scrollY = window.scrollY;
    return {
      top: nodeCoords.top - (tipHeight + 10) + window.scrollY,
      left: nodeCenter - (tipWidth / 2) + window.scrollX
    };
  };

  return Tooltip;

})();
