class ChangeDataCareerToUser < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :career, :string
  end
end
