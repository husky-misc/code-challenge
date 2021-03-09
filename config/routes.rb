Rails.application.routes.draw do
  resources :games, only: [:new, :create, :index]
  root to: 'games#new'
end
