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
    (1..12).each do |m|
      vals = res.map { |_, months| months[m] }.compact
      if vals.empty?
        averages[m] = 0.0
      else
        averages[m] = vals.sum / vals.size
      end
    end
    res = res.sort_by { |y, _| y }
    [res, averages]
  end
end
