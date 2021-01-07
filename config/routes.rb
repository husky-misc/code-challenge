Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :ap1 do
    namespace :v1 do
      get '/customer/:customer_id/credit_card/:credit_card_id/transactions', to: 'transactions#index'

      post '/customer/:customer_id/credit_card/:credit_card_id/charge', to: 'credit_cards#charge'
    end
  end
end
