Rails.application.routes.draw do
  root to: 'stories#index'

  resources :feeds
  resources :stories do
    post :refresh, on: :collection
  end

  namespace :users do
    resources :passwords
    resources :sessions
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end
