Rails.application.routes.draw do
  resources :matches, only: :index

  root "matches#index"
end
