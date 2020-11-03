# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Airport.create(code: 'RDU')
Airport.create(code: 'SYD')
Airport.create(code: 'ICN')
Airport.create(code: 'YEG')
Airport.create(code: 'DEN')

Flight.create(from_airport_id: 1, to_airport_id: 2, price: 100.50, departure: '30/10/2020', flight_duration: 19000)
Flight.create(from_airport_id: 2, to_airport_id: 1, price: 100.50, departure: '31/10/2020', flight_duration: 19000)
Flight.create(from_airport_id: 2, to_airport_id: 3, price: 95.30, departure: '01/11/2020', flight_duration: 15000)
Flight.create(from_airport_id: 1, to_airport_id: 5, price: 90.00, departure: '01/11/2020', flight_duration: 10000)
Flight.create(from_airport_id: 5, to_airport_id: 4, price: 100.00, departure: '03/11/2020', flight_duration: 18000)
