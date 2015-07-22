class AddUsersToPostsAndReplies < ActiveRecord::Migration
  def change
    add_reference :forum_posts, :user, index: true
    add_reference :forum_replies, :user, index: true
  end
end
