class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.text :name, :null => false
      t.string :description, :null => false
      t.integer :position, :null => false, :default => 100
      t.references :forum_category, index: true
      t.integer :status, :null => false, :default => 0

      t.timestamps
    end
  end
end
