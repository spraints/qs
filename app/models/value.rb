class Value < ActiveRecord::Base
  belongs_to :metric

  delegate :name, :to => :metric

  default_scope ->{ order('created_at DESC') }

  def occurred_at
    created_at
  end
end
