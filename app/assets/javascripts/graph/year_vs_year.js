function YearVsYear() {
  function eachDay(start, cb) {
    for (var d = start; d <= 366; d++) {
      cb(d);
    }
  }

  this.append = function(point) {
    var thisMoment = moment(point.date);
    var year = setUpYear(thisMoment.year());
    year.increment(thisMoment.dayOfYear(), point.value);
  }

  var results = this.results = [];
  eachDay(0, function(d) { results[d] = {x:d, y:{}} });
  results.xScale = d3.scale.linear();
  results.series = [];
  results.yDomain = [0, 1];

  var years = {};
  function setUpYear(year) {
    if (!years[year]) {
      years[year] = new Year(year);
      results.series.push(years[year].name);
    }
    return years[year];
  }

  function Year(year) {
    var name = this.name = year.toString();
    eachDay(0, function(d) { results[d].y[name] = 0; });
    this.increment = function(dayOfYear, value) {
      var last = 0;
      eachDay(dayOfYear, function(d) { last = results[d].y[name] = results[d].y[name] + value; });
      if (last > results.yDomain[1])
        results.yDomain[1] = last;
    }
  }
}
