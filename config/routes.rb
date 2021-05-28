# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  
  root "conversations#index"
  resources :conversations
  resources :comments
  devise_for :users

  resources :users, only: :show

  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
