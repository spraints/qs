function Derivative(options) {
  var results = this.results = [];
  var periodMs = moment.duration(1, options.period).asMilliseconds();

  var rightDirection = function(dx) { return true; }
  if (options.direction == "negative") {
    rightDirection = function(dx) { return dx <= 0; };
  } else if (options.direction == "positive") {
    rightDirection = function(dx) { return dx >= 0; };
  }

  var lastPoint = null;
  var lastRate = null;
  this.append = function(point) {
    if (lastPoint) {
      var dx = point.value - lastPoint.value;
      if (rightDirection(dx)) {
        var dyMs = point.date - lastPoint.date;
        var dyPeriod = dyMs / periodMs;
        var rate = lastRate = dx / dyPeriod;
        results.push({x: lastPoint.date, y: {value: rate}});
        results.push({x:     point.date, y: {value: rate}});
      } else if (lastRate != null) {
        results.push({x:     point.date, y: {value: lastRate}});
      }
      console.groupEnd();
    }
    lastPoint = point;
  }
}
