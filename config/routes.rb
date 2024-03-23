Rails.application.routes.draw do
  resources :todos, only: [:index, :create, :update, :destroy]
  resources :users, only: [:create]
  post '/guest-login', to: 'users#guest_login'
end
