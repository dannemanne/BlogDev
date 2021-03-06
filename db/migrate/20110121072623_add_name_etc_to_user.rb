class AddNameEtcToUser < ActiveRecord::Migration[4.2]
  def self.up
    add_column :users, :name, :string
    add_column :users, :role, :integer, :null => false, :default => 0
    add_column :users, :use_gravatar, :boolean, :null => false, :default => false

    add_index :users, :role
  end

  def self.down
    remove_column :users, :name
    remove_column :users, :role
    remove_column :users, :use_gravatar
  end
end
