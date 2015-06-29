//= require 'd3/d3'
//= require 'moment/moment'

$(function() {

graphs = $('.graph-placeholder');
if(graphs.length == 0)
  return;

function by(period) {
  return function(raw) {
    var data = new DataByPeriod(period);
    raw.forEach(function(x) { data.append(x); });
    return data.aggregates;
  }
}

function DataByPeriod(period) {
  var results = this.aggregates = [];

  this.append = function(point) {
    var aggPoint = setUpPoint(point.date);
    aggPoint.value = aggPoint.value + point.value;
  }

  var current = null;

  function setUpPoint(date) {
    date = moment(date).startOf(period);
    if (current) {
      dateUnix = date.unix();
      while (current.unix < dateUnix) {
        newPoint(current.moment.add(1, period));
      }
    } else {
      newPoint(date);
    }
    return current.point;
  }

  function newPoint(moment) {
    var point = {date: moment.clone().toDate(), value: 0};
    results.push(point);
    current = {moment: moment, unix: moment.unix(), point: point};
  }
}

if (graphs[0].classList.contains("by_week")) {
  transform = by("week");
} else if (graphs[0].classList.contains("by_month")) {
  transform = by("month");
} else if (graphs[0].classList.contains("by_year")) {
  transform = by("year");
} else if (graphs[0].classList.contains("year_v_year")) {
  transform = year_v_year;
} else {
  transform = function(x) { return x; };
}

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
}).toArray().sort(function(a, b) { return d3.ascending(a.date, b.date); });
data = transform(data);

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

svg.append("path")
    .datum(data)
    .attr("class", "line")
    .attr("d", line);

});
