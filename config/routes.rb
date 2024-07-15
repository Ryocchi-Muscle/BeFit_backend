Rails.application.routes.draw do
  post 'auth/:provider/callback', to: 'api/v1/users#create'
  namespace :api do
    namespace :v1 do
      resources :users, only: [:destroy], params: :uid
    end
  end

  namespace :api do
    namespace :v2 do
      post 'personalized_menus/create_and_save', to: 'personalized_menus#create_and_save'
      resources :personalized_menus, only: [:index,:destroy, :update]
      resources :training_records, only: [:index, :show, :update] do
        get 'weekly_summary', on: :collection
        get 'check_completion/:date/:program_id', to: 'training_records#check_completion', on: :collection
      end
    end
  end
end
