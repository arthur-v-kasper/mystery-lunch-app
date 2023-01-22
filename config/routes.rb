# frozen_string_literal: true

Rails.application.routes.draw do

  post '/auth', to: 'users#auth'

  get '/departments', to: 'departments#index'

  resources :employees
end
