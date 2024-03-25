Rails.application.routes.draw do
  resources :todos, only: [:index, :create, :update, :destroy]
  resources :users, only: [:create]
  # post '/guest_login', to: 'users#guest_login'
  post 'auth/:provider/callback', to: 'api/v1/users#create'
  delete '/users/:id', to: 'api/v1/users/destroy'
end
