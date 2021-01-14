Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :customers, only: [] do
    get 'credit_cards/:credit_card_id/transactions', to: 'customers#credit_card_transactions', on: :member
    post 'credit_cards/:credit_card_id/charge', to: 'customers#charge_credit_card', on: :member
  end
end
