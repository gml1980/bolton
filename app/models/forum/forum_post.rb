class Forum::ForumPost < ActiveRecord::Base
  belongs_to :forum, class_name: 'Forum::Forum'
  belongs_to :user
  validates_presence_of :subject, :post_body, :forum
  has_many :forum_replies, class_name: 'Forum::ForumReply'
  has_many :file_attachments

  def posted_by
    if user.nil?
      return "Deleted"
    else
      return user.display_name_for_posts
    end
  end

  def last_reply_time
    if forum_replies.count > 0
      forum_replies.latest_first.first.created_at
    end
  end
end