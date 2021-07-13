class AddNameAndWebsiteToComment < ActiveRecord::Migration[4.2]
  def up
    add_column :comments, :name, :string
    add_column :comments, :website, :string
    rename_column :comments, :message, :message_old
    add_column :comments, :message, :text
    begin
      Comment.all.each do |c|
        c.message = c.message_old
        c.save
      end
    rescue StandardError
    end
  end

  def down
    remove_column :comments, :message
    rename_column :comments, :message_old, :message
    remove_column :comments, :website
    remove_column :comments, :name
  end
end
