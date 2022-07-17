class AddDetailsToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :subject, :string
    add_column :tickets, :team_id, :integer
  end
end
