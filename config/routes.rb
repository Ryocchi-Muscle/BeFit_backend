Rails.application.routes.draw do
  post 'auth/:provider/callback', to: 'api/v1/users#create'
  delete '/users/:uid', to: 'users#destroy'
  namespace :api do
    namespace :v2 do
      resources :training_records
    end
  end
end
