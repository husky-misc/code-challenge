Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/customers/:customer_id/credit_cards/:credit_card_id/transactions', to: 'transactions#index'
      put '/customers/:customer_id/credit_cards/:credit_card_id/transactions/:transaction_id/to_dispute', to: 'transactions#to_dispute'

      post '/customers/:customer_id/credit_cards/:credit_card_id/charge', to: 'credit_cards#charge'
    end
  end
end
