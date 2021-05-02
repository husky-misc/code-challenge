Rails.application.routes.draw do
  resource :import, only: [:create]
end
