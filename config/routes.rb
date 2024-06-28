Rails.application.routes.draw do
  post 'auth/:provider/callback', to: 'api/v1/users#create'
  delete '/users/:uid', to: 'users#destroy'
  namespace :api do
    namespace :v2 do
      post 'personalized_menus/create_and_save', to: 'personalized_menus#create_and_save'
      get 'personalized_menus', to: 'personalized_menus#index'
      delete 'personalized_menus/:id', to: 'personalized_menus#destroy'
      patch 'personalized_menus/:id/update', to: 'personalized_menus#update'

      resources :training_records, only: [:index, :show, :create, :update] do
        get 'weekly_summary', on: :collection
        get 'check_completion/:date/:program_id', to: 'training_records#check_completion', on: :collection
      end
    end
  end
end
