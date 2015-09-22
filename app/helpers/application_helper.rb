module ApplicationHelper
  def is_admin?
    current_user and current_user.is_admin?
  end

  def is_user?
    current_user and is_user?
  end
end
