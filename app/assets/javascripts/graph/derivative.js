function Derivative(options) {
  var results = [];
  this.results = [{x: new Date(), y: {value: 0}}, {x: new Date(), y: {value: 0}}];
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
        if (results.length == 0)
          results.push({x: lastPoint.date, y: {value: rate}});
        results.push({x:     point.date, y: {value: rate}});
      } else if (lastRate != null) {
        results.push({x:     point.date, y: {value: lastRate}});
      }
      if (results.length > 2)
        this.results = results;
    }
    lastPoint = point;
  }
}
