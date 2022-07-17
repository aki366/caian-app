class RenameMessageTextColumnToMessages < ActiveRecord::Migration[6.1]
  def change
    rename_column :messages, :message_text, :text
  end
end
