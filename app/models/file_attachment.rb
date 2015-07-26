class FileAttachment < ActiveRecord::Base
	belongs_to :forum_post, class_name: 'Forum::ForumPost'
	belongs_to :forum_reply, class_name: 'Forum::ForumReply'
  has_attached_file :post_file
  do_not_validate_attachment_file_type :post_file
end
