class AddNofollowToComment < ActiveRecord::Migration
  def change
    add_column :comments, :no_follow, :boolean, :null => false, :default => false
  end
end
