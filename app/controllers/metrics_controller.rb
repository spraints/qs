class MetricsController < ApplicationController
  before_filter :require_user!

  def index
    view_model.recent_metrics = current_user.recent_metrics
  end

  def create
    current_user.measure(params[:name], params[:value])
    redirect_to :action => "index"
  end

  def show
    view_model.metric = current_user.find_metric(params[:id])
    view_model.values = view_model.metric.values
    view_model.metric_types = metric_types
  end

  private

  def metric_types
    [
      TemporaryMetricType.new("simple", "Simple", true),
      TemporaryMetricType.new("daily", "Daily"),
      TemporaryMetricType.new("weekly", "Weekly"),
    ]
  end

  class TemporaryMetricType < Struct.new(:id, :name, :active)
    def active?
      active
    end

    def to_s
      name
    end
  end
end
