class Forum::ForumReply < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum_post, class_name: 'Forum::ForumPost'
  validates_presence_of :post_body
  has_many :file_attachments

  scope :latest_first, -> { order(created_at: :desc) }

  def posted_by
    if user.nil?
      return "Deleted"
    else
      return user.display_name_for_posts
    end
  end
end
