class CreateForumForumReplies < ActiveRecord::Migration
  def change
    create_table :forum_replies do |t|
      t.string :post_body, :null => false
      t.references :forum_post, index: true, :null => false
      t.references :forum_replies, index: true, :null => true
      t.boolean :email_users, :default => false

      t.timestamps
    end
  end
end
