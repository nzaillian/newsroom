Rails.application.routes.draw do
  root to: 'stories#index'

  resources :feeds
  resources :stories do
    post :refresh, on: :collection
  end

  get '/feed/:api_key/rss.xml' => 'stories#rss', as: :rss

  namespace :users do
    resources :passwords
    resources :sessions
  end

  get 'info' => 'pages#info'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end
