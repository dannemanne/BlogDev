class AddAllowCommentsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :allow_comments, :boolean, :null => false, :default => false

  end
end
