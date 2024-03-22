Rails.application.routes.draw do
  resources :todos, only: [:index, :create, :update, :destroy]
  resources :users, only: [:create]
end
