class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def is_admin?
    current_user and current_user.is_admin?
  end

  def is_user?
    current_user and current_user.is_user?
  end
end
