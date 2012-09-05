class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :user
      t.string :image_content_type
      t.string :image_file_size
      t.string :image_file_name
      t.datetime :image_updated_at

      t.timestamps
    end
    add_index :images, :user_id
  end
end
