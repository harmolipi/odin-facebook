Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts
  resources :users, only: [:show]
  resources :friend_requests, only: [:index, :create, :destroy]
  resources :friendships, only: [:index, :create, :destroy]
  resources :likes, only: [:create, :destroy]
end
