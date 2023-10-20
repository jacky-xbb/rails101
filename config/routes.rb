Rails.application.routes.draw do
  devise_for :users

  resources :groups do
    resources :posts
  end

  resources :groups do
    member do
      get :join
      get :quit
    end
  end

  namespace :account do
    resources :groups
    resources :posts
  end

  get "up" => "rails/health#show", as: :rails_health_check

  resources :groups
  get "groups/:id/delete" => "groups#delete", as: :delete_group

  root "groups#index"
end
