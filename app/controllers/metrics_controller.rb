class MetricsController < ApplicationController
  before_filter :require_user!

  def index
    view_model.all_metrics = current_user.metrics
    view_model.recent_metrics = current_user.recent_metrics
  end

  def create
    current_user.measure(params[:name], params[:value])
    case params[:return_to]
    when "show"
      redirect_to :action => "show", :id => params[:name]
    else
      redirect_to :action => "index"
    end
  end

  def show
    view_model.metric = current_user.find_metric(params[:id])
    view_model.values = view_model.metric.values
    view_model.style = Style.for(params[:style])
  end
end
