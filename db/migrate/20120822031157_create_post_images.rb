class CreatePostImages < ActiveRecord::Migration[4.2]
  def change
    create_table :post_images do |t|
      t.references :post
      t.references :image
    end
    add_index :post_images, :post_id
    add_index :post_images, :image_id
  end
end
