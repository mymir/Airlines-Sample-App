class CreditCardsController < ApplicationController

  def new
    @credit_card = CreditCard.new
    @booking = Booking.find(params[:id])
  end

  def make_purchase
    return if error_saving_card
    @booking = Booking.find(params[:booking_id])

    response = Spreedly.get_payment_method(params[:token])
    return render_unable_to_retieve_card(response) unless response.code == 200

    @credit_card = CreditCard.new(response)
    return render_invalid_card(response) unless @credit_card.valid?

    response = Spreedly.purchase(params[:token], amount_to_charge, @credit_card.retained)
    @booking.update(:success => true) if response.code == 200
    return redirect_to booking_path(@booking) if response.code == 200

    render_unable_to_purchase(response)
  end

  def make_delivery
    return if error_saving_card
    @booking = Booking.find(params[:booking_id])

    response = Receiver.get_payment_method(params[:token])
    return render_unable_to_retieve_card(response) unless response.code == 200

    @credit_card = CreditCard.new(response)
    return render_invalid_card(response) unless @credit_card.valid?

    response = Receiver.deliver(params[:token])
    @booking.update(:success => true) if response.code == 200

    return redirect_to booking_path(@booking) if response.code == 200

    render_unable_to_purchase(response)
  end

  private

  def amount_to_charge
    @booking = Booking.find(params[:booking_id])
    cost = (( @booking.flight.price * @booking.num_passengers ) * 100).to_i
    return cost
  end

  def render_unable_to_retieve_card(response)
    flash.now[:error] = response["errors"]["error"]["__content__"]
    render_book_flight
  end

  def render_invalid_card(response)
    flash.now[:error] = "Invalid card"
    render_book_flight
  end

  def render_unable_to_purchase(response)
    return render_unable_to_retieve_card(response) if response["errors"]
    flash.now[:error] = "#{response['transaction']['response']['message']} #{response['transaction']['response']['error_detail']}"

    render_book_flight
  end

  def render_book_flight
    render(:action => :new)
  end

  def error_saving_card
    return false if params[:error].blank?

    flash.now[:error] = params[:error]
    render_book_flight
    true
  end

end
