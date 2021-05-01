Rails.application.routes.draw do
  resources :matches, only: [:index, :show]

  root "matches#index"
end
