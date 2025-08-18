require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = FactoryGirl.create(:user)
  end

  def test_metric_is_created_for_a_measurement
    initial_count = Metric.count
    @user.measure("new.metric", 100)
    assert_equal initial_count + 1, Metric.count
  end

  def test_value_is_created_for_a_measurement
    initial_count = Value.count
    @user.measure("new.metric", 100)
    assert_equal initial_count + 1, Value.count
  end

  def test_effects_of_creating_a_metric
    @user.measure("new.metric", 50)
    assert_equal ["new.metric"], Metric.where(user_id: @user.id).pluck(:name)
    assert_equal [50], Metric.where(user_id: @user.id).first.values.pluck(:value)

    metric_count = Metric.count
    value_count = Value.count
    @user.measure("new.metric", 100)
    assert_equal metric_count, Metric.count, "expect no new metrics"
    assert_equal value_count + 1, Value.count, "expect another new value"
  end
end
