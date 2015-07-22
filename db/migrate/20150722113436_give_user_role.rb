class GiveUserRole < ActiveRecord::Migration
  def change
    add_column :users, :user_role, :integer, :default => 2
  end
end
