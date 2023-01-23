# frozen_string_literal: true

Rails.application.routes.draw do

  post '/auth', to: 'users#auth'

  get '/departments', to: 'departments#index'

  get '/mystery_lunches', to: 'mystery_lunches#index'

  resources :employees
end
