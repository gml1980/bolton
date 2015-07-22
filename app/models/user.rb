class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #
  # Disabled:
  #   :registerable :validatable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable
  enum user_role: { super_admin: 0, admin: 1, user: 2, disabled: 3}
  has_many :forum_posts
  has_many :forum_replies

  def is_admin?
  	return super_admin? || admin?
  end

  def display_name_for_posts
    return email
  end
end
