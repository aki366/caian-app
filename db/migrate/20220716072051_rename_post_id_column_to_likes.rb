class RenamePostIdColumnToLikes < ActiveRecord::Migration[6.1]
  def change
    rename_column :likes, :post_id, :ticket_id
  end
end
