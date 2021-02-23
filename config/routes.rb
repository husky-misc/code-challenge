Rails.application.routes.draw do
  get 'dashboard/index'
  get 'dashboard/show'
  post 'dashboard/upload_file'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
