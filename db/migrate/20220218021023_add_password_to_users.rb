class AddPasswordToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password, :string, after: :email
  end
end