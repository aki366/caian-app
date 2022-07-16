class RenamePostIdColumnToComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :post_id, :ticket_id
  end
end
