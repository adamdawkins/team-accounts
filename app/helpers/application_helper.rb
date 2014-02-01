module ApplicationHelper
  def current_user
    user_id = session[:user_id]
    current_user ||= User.find(user_id) if user_id
    current_user
  end
end
