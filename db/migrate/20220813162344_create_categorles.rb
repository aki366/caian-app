class CreateCategorles < ActiveRecord::Migration[6.1]
  def change
    create_table :categorles do |t|
      t.string :name

      t.timestamps
    end
  end
end
