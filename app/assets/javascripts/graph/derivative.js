function Derivative(period) {
  var results = this.results = [];
  var periodMs = moment.duration(1, period).asMilliseconds();

  var lastPoint = null;
  this.append = function(point) {
    if (lastPoint) {
      var dx = point.value - lastPoint.value;
      var dyMs = point.date - lastPoint.date;
      var dyPeriod = dyMs / periodMs;
      var rate = dx / dyPeriod;
      results.push({x: lastPoint.date, y: {value: rate}});
      results.push({x:     point.date, y: {value: rate}});
    }
    lastPoint = point;
  }
}
