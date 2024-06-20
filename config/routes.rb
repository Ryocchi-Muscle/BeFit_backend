Rails.application.routes.draw do
  post 'auth/:provider/callback', to: 'api/v1/users#create'
  delete '/users/:uid', to: 'users#destroy'
  namespace :api do
    namespace :v2 do
      post 'personalized_menus/create_and_save', to: 'personalized_menus#create_and_save'
      patch 'personalized_menus/:id/save_daily_program', to: 'personalized_menus#save_daily_program'
      get 'personalized_menus', to: 'personalized_menus#index'
      delete 'personalized_menus/:id', to: 'personalized_menus#destroy'

      resources :training_records, only: [:index, :show, :create, :weekly_summary] do
        get 'weekly_summary', on: :collection
      end
    end
  end
end
