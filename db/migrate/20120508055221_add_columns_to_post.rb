class AddColumnsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :parsed_body, :text
    add_column :posts, :parsed_preview, :text
  end
end
