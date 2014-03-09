class User < ActiveRecord::Base
  has_many :metrics

  def to_s
    username
  end

  def measure(name, value)
    metrics.named(name) << value
  end
end
