class RenameCommentTextColumnToComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :comment_text, :text
  end
end
