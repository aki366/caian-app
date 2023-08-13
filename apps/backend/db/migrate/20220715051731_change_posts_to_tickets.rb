class ChangePostsToTickets < ActiveRecord::Migration[6.1]
  def change
    rename_table :posts, :tickets
  end
end
