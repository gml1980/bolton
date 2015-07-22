class CreateForumCategories < ActiveRecord::Migration
  def change
    create_table :forum_categories do |t|
      t.text :name, null: false
      t.string :description, null: false
      t.integer :position, default: 100, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
