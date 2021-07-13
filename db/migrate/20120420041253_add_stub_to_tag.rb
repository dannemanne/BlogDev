class AddStubToTag < ActiveRecord::Migration[4.2]

  def change
    add_column :tags, :stub, :string
    begin
      Tag.all.each do |tag|
        tag.stub_will_change!
        tag.save
      end
    rescue StandardError
    end
    change_column :tags, :stub, :string, :null => false
    add_index :tags, :stub
  end
end
