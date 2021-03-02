Rails.application.routes.draw do
  resources :games, only: [:new, :create]
  root to: 'games#new'
end
