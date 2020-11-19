class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.decimal :price
      t.date :departure
      t.integer :flight_duration
      t.references :from_airport
      t.references :to_airport

      t.timestamps
    end
  end
end
