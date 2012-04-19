class CreatePostTags < ActiveRecord::Migration
  def change
    create_table :post_tags do |t|
      t.references :post
      t.references :tag
    end
    add_index :post_tags, :post_id
    add_index :post_tags, :tag_id
    add_index :post_tags, [:tag_id, :post_id], :unique => true
  end
end
