class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  helper :all

  def authenticate_user
    unless current_user
      redirect_to login_path, error: 'You need to login to view that page'
    end
  end

  def login(user_id)
    if session[:user_id]
      fail 'user already logged in'
    else
      session[:user_id] = user_id
    end
  end
end
