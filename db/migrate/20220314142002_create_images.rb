class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.string :ticket_id
      t.string :title
      t.string :image_id
      t.string :post_id

      t.timestamps
    end
  end
end
