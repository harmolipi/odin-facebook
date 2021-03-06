Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'posts#index'
  resources :posts, only: [:index, :new, :create, :show, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
  resources :friend_requests, only: [:index, :create, :destroy]
  resources :friendships, only: [:index, :create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  get '/privacy-policy', to: 'privacy_policy#show'
end
