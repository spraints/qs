class MetricsController < ApplicationController
  before_filter :require_user!

  def index
    view_model.recent_metrics = current_user.recent_metrics
  end

  def create
    current_user.measure(params[:name], params[:value])
    redirect_to :action => "index"
  end
end
