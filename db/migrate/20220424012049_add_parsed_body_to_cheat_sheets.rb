class AddParsedBodyToCheatSheets < ActiveRecord::Migration[6.0]
  def change
    add_column :cheat_sheets, :parsed_body, :text
  end
end
