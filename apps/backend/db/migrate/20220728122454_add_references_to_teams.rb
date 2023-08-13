class AddReferencesToTeams < ActiveRecord::Migration[6.1]
  def change
    add_reference :teams, :room, foreign_key: true
  end
end
