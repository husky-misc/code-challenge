Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :bank_accounts, only: [:index, :create], defaults: { format: :json } do
        resources :transactions, only: [:create]
        resources :bank_statements, only: [:index]
      end
    end
  end
end
