Rails.application.routes.draw do
  post '/store', to: 'ips#create'
  get '/compute', to: 'ips#index'

  get '/compute_history', to: 'computes_history#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
