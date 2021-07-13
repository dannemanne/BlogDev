class AddTitleUrlToPost < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :title_url, :string
    add_index :posts, :title_url, :unique => true
  end
end
