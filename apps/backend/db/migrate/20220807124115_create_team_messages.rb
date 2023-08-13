class CreateTeamMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :team_messages do |t|
      t.text :text
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
