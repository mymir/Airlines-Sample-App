class BookingsController < ApplicationController

  def search
    return unless params[:id]

    ids = Booking.ids
    if params[:id].to_i.in?(ids)
      redirect_to booking_path(params[:id])
    else
      flash.now['error'] = 'Booking not found.'
    end
  end

  def new
    @booking = Booking.new
    (1..params[:passenger_count].to_i).each do
      @booking.passengers.build
    end
    @flight = Flight.find(params[:flight_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.save

    redirect_to booking_path(@booking)
  end

  def show
    @booking = Booking.find(params[:id])
    @flight = @booking.flight
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: %i[id name email])
  end

end
