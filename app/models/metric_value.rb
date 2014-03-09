class MetricValue
  include ActiveModel::Model

  def self.measure(name, value, options = {})
    user = options.fetch(:user)
    new(user.metrics.named(name).add(value))
  end

  def initialize(value = nil)
    @value = value
  end

  delegate :name, :value, :to => :@value
end
