class AddReferencesToTicketCategorles < ActiveRecord::Migration[6.1]
  def change
    add_index :ticket_categorles, :ticket_id
    add_index :ticket_categorles, :categorle_id
    add_foreign_key :ticket_categorles, :tickets
    add_foreign_key :ticket_categorles, :categorles
  end
end
