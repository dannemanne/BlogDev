class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.references :user, :null => false
      t.string :title
      t.text :body
      t.integer :status, :null => false, :default => 0
      t.datetime :posted_at
      t.integer :comments_count, :null => false, :default => 0

      t.timestamps
    end

    add_index :posts, :user_id
    add_index :posts, :posted_at
    add_index :posts, :status
  end

  def self.down
    drop_table :posts
  end
end
