class Passenger < ApplicationRecord
  belongs_to :booking, optional: true
  # validates_presence_of :booking
end
