module CurrentUser
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  def require_user!
    if current_user.nil?
      session[:after_auth] ||= request.url
      redirect_to '/auth/google'
    end
  end

  def current_user
    @current_user ||= user_from_session || :anonymous
    @current_user == :anonymous ? nil : @current_user
  end

  def current_user=(user)
    session['current_user_id'] = user.id
    @current_user = user
  end

  private

  def user_from_session
    User.where(:id => session['current_user_id']).first
  end
end
