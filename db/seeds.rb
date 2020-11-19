# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Airport.create(code: 'RDU')
Airport.create(code: 'SYD')
Airport.create(code: 'ICN')
Airport.create(code: 'YEG')
Airport.create(code: 'DEN')

Flight.create(from_airport_id: 1, to_airport_id: 2, price: 150.50, departure: '30/10/2020', flight_duration: 23)
Flight.create(from_airport_id: 2, to_airport_id: 1, price: 150.50, departure: '31/10/2020', flight_duration: 23)
Flight.create(from_airport_id: 2, to_airport_id: 3, price: 105.30, departure: '01/11/2020', flight_duration: 10)
Flight.create(from_airport_id: 1, to_airport_id: 5, price: 75.00, departure: '01/11/2020', flight_duration: 4)
Flight.create(from_airport_id: 5, to_airport_id: 4, price: 90.00, departure: '03/11/2020', flight_duration: 6)
