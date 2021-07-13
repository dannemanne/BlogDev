class CreateTags < ActiveRecord::Migration[4.2]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :posts_count, :null => false, :default => 0
    end

    add_index :tags, :posts_count
  end
end
