Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      controller :ip do
        post :store, :defaults => {:format => 'json'}
        post :compute, :defaults => {:format => 'json'}
        get  :compute_histories, :defaults => {:format => 'json'}
      end
    end
  end
end
