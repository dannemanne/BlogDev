class AddNameEtcToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :role, :integer

    add_index :users, :role
  end

  def self.down
    remove_column :users, :name
    remove_column :users, :role
  end
end
