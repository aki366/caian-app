class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :user_image
      t.string :profile
      t.string :career

      t.timestamps
    end
  end
end
