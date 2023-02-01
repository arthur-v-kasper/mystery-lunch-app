# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'main#index'
  post '/auth', to: 'users#auth'
  get '/departments', to: 'departments#index'
  get '/mystery_lunches', to: 'mystery_lunches#index'
  resources :employees, defaults: { format: 'json' }
end
