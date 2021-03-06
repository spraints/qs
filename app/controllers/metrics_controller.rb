require "csv"

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
  end

  def export
    metric = current_user.find_metric(params[:id])
    values = metric.values
    csv = CSV.generate do |csv|
      values.each do |value|
        csv << [value.occurred_at, value.value]
      end
    end
    render :text => csv
  end
end
