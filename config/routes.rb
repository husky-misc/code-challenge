Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  api_version(:module => "V1", :path => {:value => "v1"}) do
    resources :bank_statements do
      resource :transactions, only: [:show]
      resource :transactions, only: [:show], path: 'relationships/transactions'
      
      resource :transaction, only: [:update, :create, :destroy]
      resource :transaction, only: [:update, :create, :destroy], path: 'relationships/transaction'
    end
  end
end
