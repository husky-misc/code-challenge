Rails.application.routes.draw do
  resources :bank_statements do
    resource :transactions, only: [:show]
    resource :transactions, only: [:show], path: 'relationships/transactions'
    
    resource :transaction, only: [:update, :create, :destroy]
    resource :transaction, only: [:update, :create, :destroy], path: 'relationships/transaction'
  end
end
