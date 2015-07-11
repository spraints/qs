//= require 'd3/d3'
//= require 'moment/moment'
//= require 'graph/data_by_period'
//= require 'graph/derivative'
//= require 'graph/year_vs_year'

$(function() {

graphs = $('.graph-placeholder');
if(graphs.length == 0)
  return;

function by(period) {
  return function(raw) {
    return aggregate(new DataByPeriod(period), raw);
  }
}

function per(dyPeriod) {
  return function(raw) {
    return aggregate(new Derivative(dyPeriod), raw);
  }
}

function year_v_year(raw) {
  return aggregate(new YearVsYear(), raw);
}

function aggregate(collector, raw) {
  raw.forEach(function(x) { collector.append(x); });
  return collector.results;
}

if (graphs[0].classList.contains("by_week")) {
  transform = by("week");
} else if (graphs[0].classList.contains("by_month")) {
  transform = by("month");
} else if (graphs[0].classList.contains("by_year")) {
  transform = by("year");
} else if (graphs[0].classList.contains("year_v_year")) {
  transform = year_v_year;
} else if (graphs[0].classList.contains("per_week")) {
  transform = per("week");
} else {
  transform = function(raw) {
    return raw.map(function(point) { return {x:point.date, y:{value:point.value}}; });
  };
}

// e.g. "2014-03-10 21:04:57 UTC"
var parseDate = d3.time.format("%Y-%m-%d %H:%M:%S UTC").parse;

var data = $('.data-point').map(function() {
  return {"date": parseDate(this.dataset["x"]), "value": +this.dataset["y"]};
}).toArray().sort(function(a, b) { return d3.ascending(a.date, b.date); });
data = transform(data);


var margin = {top: 20, right: 20, bottom: 30, left: 100},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var x = (data.xScale || d3.time.scale())
    .range([0, width]);

var y = d3.scale.linear()
    .range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

var container = d3.select(".graph-placeholder");
var svg = container.append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
var legend = container.append("div").attr("class", "legend");

x.domain(d3.extent(data, function(d) { return d.x; }));
y.domain(data.yDomain || d3.extent(data, function(d) { return d.y.value; }));

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
    .attr("dy", ".71em");

(data.series || ["value"]).forEach(function(series, i) {
  var line = d3.svg.line()
      .x(function(d) { return x(d.x); })
      .y(function(d) { return y(d.y[series]); });

  svg.append("path")
      .datum(data)
      .attr("class", "line line" + i)
      .attr("d", line);

  if (series != "value") {
    legend.append("span").attr("class", "legend" + i).text(series);
  }
});

});
