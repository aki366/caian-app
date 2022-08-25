class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.bigint :ticket_id
      t.string :title
      t.bigint :image_id
      t.bigint :post_id

      t.timestamps
    end
  end
end
