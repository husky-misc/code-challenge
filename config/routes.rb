# frozen_string_literal: true

Rails.application.routes.draw do
  resources :accounts,     only: [:create]
  resources :transactions, only: [:create]
end
