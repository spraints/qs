module TablePerMonthHelper
  def table_per_month(values)
    res = {}
    values.each do |value|
      y = value.occurred_at.year
      m = value.occurred_at.month
      res[y] ||= {}
      res[y][m] ||= 0
      res[y][m] += value.value
      res[y][:total] ||= 0
      res[y][:total] += value.value
    end
    averages = Hash.new(0.0)
    stddevs = Hash.new(1.0)
    (1..12).each do |m|
      vals = res.map { |_, months| months[m] }.compact
      next if vals.empty?
      mean = vals.sum / vals.size
      var = vals.map { |v| v.to_f - mean }.map { |d| d * d }.sum / vals.size
      averages[m] = mean
      stddevs[m] = Math.sqrt(var)
    end
    res = res.sort_by { |y, _| y }
    [res, averages, stddevs]
  end

  def heat_class(value:, mean:, stddev:)
    value ||= 0.0
    mean ||= 0.0
    stddev ||= 1.0
    ratio = (value.to_f - mean.to_f) / stddev.to_f
    case
    when ratio < -2.0
      "extreme-low"
    when ratio < -1.0
      "low"
    when ratio < 0.5
      "average"
    when ratio < 1.0
      "high"
    else
      "extreme-high"
    end
  end
end
