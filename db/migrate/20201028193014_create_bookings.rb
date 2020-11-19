class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.references :flight
      t.integer :num_passengers
      t.boolean :success

      t.timestamps
    end
  end
end
