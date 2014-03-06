class ApplicationController < ActionController::Base
  include CurrentUser

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  helper_method :view_model
  def view_model
    @view_model ||= OpenStruct.new
  end
end
