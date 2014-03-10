class User < ActiveRecord::Base
  has_many :metrics
  has_many :values, :through => :metrics

  def to_s
    username
  end

  def measure(name, value)
    metrics.named(name) << value
  end

  def recent_metrics
    values.order('created_at DESC').limit(10).includes(:metric)
  end
end
