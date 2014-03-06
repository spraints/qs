class SessionsController < ApplicationController
  def create
    auth = OmniauthResult.new(:omniauth => request.env['omniauth.auth'])
    self.current_user = auth.user
    redirect_to session.delete(:after_auth) || root_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  protected

  def protect_against_forgery?
    return false if action_name == 'create'
    super
  end

  def admin_required?
    false
  end
end
