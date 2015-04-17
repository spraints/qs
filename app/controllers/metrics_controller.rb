class MetricsController < ApplicationController
  before_filter :require_user!

  def index
    view_model.all_metrics = current_user.metrics
    view_model.recent_metrics = current_user.recent_metrics
  end

  def create
    current_user.measure(params[:name], params[:value])
    redirect_to :action => "index"
  end

  def show
    view_model.metric = current_user.find_metric(params[:id])
    view_model.values = view_model.metric.values
  end
end
