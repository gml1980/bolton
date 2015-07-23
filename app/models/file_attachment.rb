class FileAttachment < ActiveRecord::Base
	belongs_to :forum_post, class_name: 'Forum::ForumPost'
	belongs_to :forum_reply, class_name: 'Forum::ForumReply'
end
