class CreateFileAttachments < ActiveRecord::Migration
  def change
    create_table :file_attachments do |t|
    	t.attachment :post_file
    	t.text :description, :null => true
    	t.references :forum_post, :null => true
    	t.references :forum_reply, :null => true
      t.timestamps
    end
  end
end
