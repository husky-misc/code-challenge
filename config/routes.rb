Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/customers/:customer_id/credit_cards/:credit_card_id/transactions', to: 'transactions#index'
      post '/customers/:customer_id/credit_cards/:credit_card_id/charge', to: 'credit_cards#charge'
    end
  end
end
