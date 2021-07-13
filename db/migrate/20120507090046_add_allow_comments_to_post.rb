class AddAllowCommentsToPost < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :allow_comments, :boolean, :null => false, :default => false

  end
end
