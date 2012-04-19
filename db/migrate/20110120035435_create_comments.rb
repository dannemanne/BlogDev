class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :user
      t.references :post, :null => false
      t.string :title
      t.string :message

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :post_id

  end

  def self.down
    drop_table :comments
  end
end
