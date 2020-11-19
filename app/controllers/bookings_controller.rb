class BookingsController < ApplicationController

  def new
    @booking = Booking.new
    (1..params[:passenger_count].to_i).each do
      @booking.passengers.build
    end
    @flight = Flight.find(params[:flight_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.success = false
    @booking.save
    redirect_to controller: 'credit_cards', action: 'new', id: @booking.id
  end

  def show
    @booking = Booking.find(params[:id])
    @flight = @booking.flight
  end

  private

  def booking_params
   params.require(:booking).permit(:flight_id, :num_passengers, :success, passengers_attributes: %i[id name email])
 end

end
