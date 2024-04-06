Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :training_records
      post '/auth/:provider/callback', to: 'users#create'
      delete '/users/:uid', to: 'users#destroy'
    end
  end
end
