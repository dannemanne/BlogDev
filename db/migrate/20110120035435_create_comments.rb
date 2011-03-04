class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :user, :null => false
      t.references :post, :null => false
      t.string :title
      t.string :message

      t.timestamps
    end

  end

  def self.down
    drop_table :comments
  end
end
