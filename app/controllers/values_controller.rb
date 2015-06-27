class ValuesController < ApplicationController
  before_filter :require_user!

  def destroy
    value = Value.where(:metric_id => current_user.metrics, :id => params[:id]).first!
    value.destroy
    redirect_to :controller => "metrics", :action => "show", :id => value.metric.name
  end
end
