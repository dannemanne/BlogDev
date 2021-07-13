class CreateLinkbacks < ActiveRecord::Migration[4.2]
  def change
    create_table :linkbacks do |t|
      t.string :source_uri
      t.string :target_uri

      t.timestamps
    end
  end
end
