class Value < ActiveRecord::Base
  belongs_to :metric

  delegate :name, :to => :metric

  def occurred_at
    created_at
  end
end
