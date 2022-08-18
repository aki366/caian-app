class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.bigint :team_id
      t.bigint :user_id

      t.timestamps
    end
  end
end
