class Forum::ForumReply < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum_post, class_name: 'Forum::ForumPost'
  validates_presence_of :post_body

  def posted_by
    if user.nil?
      return "Deleted"
    else
      return user.display_name_for_posts
    end
  end
end
