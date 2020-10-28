class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.string :to
      t.string :from
      t.decimal :price

      t.timestamps
    end
  end
end
