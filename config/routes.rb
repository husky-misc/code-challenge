Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      controller :ip do
        post :store
        post :compute
        get  :compute_histories
      end
    end
  end

end
