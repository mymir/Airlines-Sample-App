Rails.application.routes.draw do
  root 'flights#index'
  resources :flights
  resources :credit_cards
  resources :bookings
  match 'get_card' => 'bookings#purchase', via: [:get, :post]
  match 'make_purchase' => 'credit_cards#make_purchase', via: [:get, :post]
  match 'make_delivery' => 'credit_cards#make_delivery', via: [:get, :post]
end
