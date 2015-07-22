class Forum::ForumPost < ActiveRecord::Base
  belongs_to :forumm, class_name: 'Forum::Forum'
  validates_presence_of :subject, :post_body, :forum
end
