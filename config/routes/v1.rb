namespace :v1, defaults: { format: :json } do
  resources :customers, only: [] do
    resources :credit_cards, on: :member, only: [] do
      post :charge, to: 'credit_cards/charges#create'
      resources :transactions, only: [:index]
    end
  end
end
