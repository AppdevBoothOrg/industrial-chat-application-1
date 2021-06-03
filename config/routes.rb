# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root "users#show"
  resources :conversations
  resources :comments
  devise_for :users
  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  resources :ratings
  #get "/ratings" => "ratings#index"
  #post "/ratings" => "ratings#create", :as => 'ratings'
  #resources :users, only: :show
  get "/:username" => "users#show"
  
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
