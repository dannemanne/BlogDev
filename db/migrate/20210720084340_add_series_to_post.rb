class AddSeriesToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :series_title, :string
    add_index :posts, :series_title
    add_column :posts, :series_part, :integer
    add_index :posts, :series_part
  end
end
