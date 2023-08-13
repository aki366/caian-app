class RenamePostIdColumnToImages < ActiveRecord::Migration[6.1]
  def change
    remove_column :images, :post_id, :string
  end
end
