Rails.application.routes.draw do
  post 'auth/:provider/callback', to: 'api/v1/users#create'
  delete '/users/:uid', to: 'users#destroy'
  get 'api/v2/training_records', to: 'api/v2/training_record#index'
  namespace :api do
    namespace :v2 do
      resources :training_records, only: [:show, :create, :weekly_summary]
    end
  end
end
