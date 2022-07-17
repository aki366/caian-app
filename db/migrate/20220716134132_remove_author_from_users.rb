class RemoveAuthorFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :career, :string
  end
end
