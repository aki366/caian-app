class AddDetailsToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :subject, :string, after: :content
    add_column :tickets, :room_id, :integer, after: :subject
    add_column :tickets, :team_id, :integer, after: :room_id
  end
end
