class Metric < ActiveRecord::Base
  belongs_to :user
  has_many :values

  def self.named(name)
    find_or_create_by(:name => name)
  end

  def <<(value)
    values.create(:value => value)
  end
end
