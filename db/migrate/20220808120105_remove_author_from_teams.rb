class RemoveAuthorFromTeams < ActiveRecord::Migration[6.1]
  def change
    remove_column :teams, :room_id, :string
    remove_column :tickets, :room_id, :string
  end
end
