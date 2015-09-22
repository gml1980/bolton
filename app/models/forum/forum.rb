class Forum::Forum < ActiveRecord::Base
  validates_presence_of :description, :name, :position, :status, :forum_category
  validates_uniqueness_of :name
  validates_numericality_of :position
  belongs_to :forum_category, class_name: 'Forum::ForumCategory'
  has_many :forum_posts, class_name: 'Forum::ForumPost'
  enum status: { active: 0, admin_only_posting: 1, admin_only_viewable: 2, inactive: 3}
  scope :user_viewable, -> { where("status in (0, 1)")}
end
