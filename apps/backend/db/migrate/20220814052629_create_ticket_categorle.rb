class CreateTicketCategorle < ActiveRecord::Migration[6.1]
  def change
    create_table :ticket_categorles do |t|
      t.references :categorle, foreign_key: true
      t.references :ticket, foreign_key: true

      t.timestamps
    end
  end
end
