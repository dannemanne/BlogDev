class AddMetaDescriptionToPost < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :meta_description, :string

  end
end
