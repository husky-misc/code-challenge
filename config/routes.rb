Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :auth, only: %i[create]
      resources :users, only: %i[create]
      resources :logs, only: %i[create show]
      resources :global_rankings, only: %i[create]
      resources :rankings, only: %i[create show delete]
    end
  end
end
