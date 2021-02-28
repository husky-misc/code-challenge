Rails.application.routes.draw do
  root 'matches#index'
  resources :matches, only: %i[index create new show] do
    get :top, on: :collection
  end
end
