# frozen_string_literal: true

Rails.application.routes.draw do
  resources :accounts,        only: [:create]
  resource  :bank_statement,  only: [:show]
  resources :transactions,    only: [:create]
end
