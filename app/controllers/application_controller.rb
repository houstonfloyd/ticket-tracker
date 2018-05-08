class ApplicationController < ActionController::Base

  #makes available in view templates
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
        redirect_back alert: "You must be logged in to do that.",
        fallback_location: root_path
    end
  end
end
