class User < ActiveRecord::Base
  has_many :metrics, :dependent => :destroy
  has_many :values, :through => :metrics

  def to_s
    username
  end

  def find_metric(name)
    metrics.named(name)
  end

  def measure(name, value)
    metrics.named(name) << value
  end

  def recent_metrics
    values.limit(10).includes(:metric)
  end
end
