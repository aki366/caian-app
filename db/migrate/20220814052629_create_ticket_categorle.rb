class CreateTicketCategorle < ActiveRecord::Migration[6.1]
  def change
    create_table :ticket_categorles do |t|
      t.bigint :ticket_id
      t.bigint :categorle_id

      t.timestamps
    end
  end
end
