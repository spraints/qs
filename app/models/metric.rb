class Metric < ApplicationRecord
  belongs_to :user
  has_many :values, :dependent => :destroy

  def self.named(name)
    find_or_create_by(:name => name)
  end

  def <<(value)
    values.create(:value => value)
  end
end
