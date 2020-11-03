class FlightsController < ApplicationController

  def index
    # @flights = Flight.all
    @airports = Airport.all
    if params[:departure]
      @flights = Flight.where(from_airport_id: params[:from_airport], to_airport_id: params[:to_airport], departure: params[:departure])
    else
      @flights = Flight.all
    end
  end

end
