class AddUserAndPostReferencesToLikes < ActiveRecord::Migration[6.1]
  def change
    add_index :likes, :user_id
    add_index :likes, :post_id
    add_foreign_key :likes, :users
    add_foreign_key :likes, :posts
  end
end
