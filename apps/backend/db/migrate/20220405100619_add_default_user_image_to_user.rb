class AddDefaultUserImageToUser < ActiveRecord::Migration[6.1]
  def up
    User.where(user_image: nil).update_all(user_image: "guest_user_icon.png")
    change_column :users, :user_image, :string, null: false, default: "guest_user_icon.png"
  end

  def down
    change_column :users, :user_image, :string
  end
end
