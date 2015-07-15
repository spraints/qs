function DataByPeriod(period) {
  var results = this.results = [];

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
    return current.point.y;
  }

  function newPoint(moment) {
    var point = {x: moment.clone().toDate(), y: {value: 0}};
    results.push(point);
    current = {moment: moment, unix: moment.unix(), point: point};
  }
}
