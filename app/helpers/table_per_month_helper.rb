module TablePerMonthHelper
  def table_per_month(values)
    res = {}
    values.each do |value|
      y = value.occurred_at.year
      m = value.occurred_at.month
      res[y] ||= {}
      res[y][m] ||= 0
      res[y][m] += value.value
    end
    res.sort_by { |y, _| y }
  end
end
