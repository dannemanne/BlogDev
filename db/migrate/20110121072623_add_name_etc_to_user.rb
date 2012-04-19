class AddNameEtcToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :role, :integer
    add_column :users, :use_gravatar, :boolean, :null => false, :default => false

    add_index :users, :role
  end

  def self.down
    remove_column :users, :name
    remove_column :users, :role
    remove_column :users, :use_gravatar
  end
end
