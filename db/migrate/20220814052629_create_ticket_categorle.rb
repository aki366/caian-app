class CreateTicketCategorle < ActiveRecord::Migration[6.1]
  def change
    create_table :ticket_categorles do |t|
      t.integer :ticket_id
      t.integer :categorle_id

      t.timestamps
    end
  end
end
