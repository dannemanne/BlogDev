class AddColumnsToPost < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :parsed_body, :text
    add_column :posts, :parsed_preview, :text
  end
end
