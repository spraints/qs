//= require 'd3/d3'

$(function() {

if($('.graph-placeholder').length == 0)
  return;

var html_data_points = $('.data-point');
var data_points = html_data_points.map(function() { return this.dataset; });


var margin = {top: 20, right: 20, bottom: 30, left: 50},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

// e.g. "2014-03-10 21:04:57 UTC"
var parseDate = d3.time.format("%Y-%m-%d %H:%M:%S UTC").parse;

var x = d3.time.scale()
    .range([0, width]);

var y = d3.scale.linear()
    .range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

var line = d3.svg.line()
    .x(function(d) { return x(d.date); })
    .y(function(d) { return y(d.value); });

var svg = d3.select(".graph-placeholder").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var data = $('.data-point').map(function() {
  return {"date": parseDate(this.dataset["x"]), "value": +this.dataset["y"]};
}).toArray();

x.domain(d3.extent(data, function(d) { return d.date; }));
y.domain(d3.extent(data, function(d) { return d.value; }));

svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis);

svg.append("g")
    .attr("class", "y axis")
    .call(yAxis)
  .append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 6)
    .attr("dy", ".71em")
    .style("text-anchor", "end")
    .text("Price ($)");

svg.append("path")
    .datum(data)
    .attr("class", "line")
    .attr("d", line);

});
