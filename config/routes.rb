Rails.application.routes.draw do
  root 'matches#index'
  resources :matches, only: %i[index create new]
end
