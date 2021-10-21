Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts, only: [:index, :new, :create, :show, :destroy]
  resources :users, only: [:index, :show]
  resources :friend_requests, only: [:index, :create, :destroy]
  resources :friendships, only: [:index, :create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
end
