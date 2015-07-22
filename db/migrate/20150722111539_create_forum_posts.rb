class CreateForumPosts < ActiveRecord::Migration
  def change
    create_table :forum_posts do |t|
      t.text :subject, :null => false
      t.string :post_body, :null => false
      t.references :forum, index: true
      t.boolean :sticky, :default => false
      t.boolean :locked, :default => false
      t.boolean :email_users, :default => false

      t.timestamps
    end
  end
end
