class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :message_text
      # t.bigint :user, foreign_key: true

      t.timestamps
    end
  end
end
