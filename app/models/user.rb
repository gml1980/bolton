class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #
  # Disabled:
  #   :registerable :validatable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable
  enum user_role: { super_admin: 0, admin: 1, user: 2, disabled: 3}

  def is_admin?
  	return super_admin? || admin?
  end
end