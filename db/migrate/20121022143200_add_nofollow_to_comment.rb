class AddNofollowToComment < ActiveRecord::Migration[4.2]
  def change
    add_column :comments, :no_follow, :boolean, :null => false, :default => false
  end
end
