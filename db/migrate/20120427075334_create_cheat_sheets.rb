class CreateCheatSheets < ActiveRecord::Migration[4.2]
  def change
    create_table :cheat_sheets do |t|
      t.string :category
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
