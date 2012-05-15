class AddMetaDescriptionToPost < ActiveRecord::Migration
  def change
    add_column :posts, :meta_description, :string

  end
end
