# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  
  
  root "conversations#index"
  resources :conversations
  resources :comments
  devise_for :users
  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  #resources :users, only: :show
  get "/users/:username" => "users#show"
  
  resources :ratings, only: :index

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
