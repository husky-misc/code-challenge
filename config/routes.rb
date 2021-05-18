# frozen_string_literal: true

Rails.application.routes.draw do
  post 'games_upload' => 'games#upload'
  root 'games#index'
end
