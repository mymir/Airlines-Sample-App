class Flight < ApplicationRecord
  belongs_to :from_airport, class_name: "Airport"
  belongs_to :to_airport, class_name: "Airport"
  has_many :bookings
  has_many :passengers, through: :bookings

  def date_formatted
    departure.strftime("%m/%d/%Y")
  end

  def self.get_departure_dates
    departure = Flight.find_by_sql("select distinct departure from flights where departure is not null order by departure asc")
  end

end
