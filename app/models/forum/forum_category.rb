class Forum::ForumCategory < ActiveRecord::Base
  validates_presence_of :description, :name, :position
  validates_uniqueness_of :name
  validates_numericality_of :position
  has_many :forums, class_name: 'Forum::Forum'
  enum status: { active: 0, admin_only: 1, inactive: 2}

  scope :user_viewable, -> { where(status: 0) }
end