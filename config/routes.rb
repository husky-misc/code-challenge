Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :customers, only: [], path: :customer do
        resources :credit_cards, only: [], path: :credit_card do
          post :charge, on: :member
        end
      end
    end
  end
end
