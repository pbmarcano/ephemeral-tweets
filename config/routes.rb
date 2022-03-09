require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  namespace :admin do
    mount Blazer::Engine, at: "/blazer"
    mount Sidekiq::Web, at: '/sidekiq'
    mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development? || Rails.env.staging?
  end

  # app routes
  get "/auth/:provider/callback", to: "sessions#create"
  resource :billing, only: :show
  resource :checkout, only: :show
  resource :dashboard, only: :show
  resource :home, only: :show
  resource :session, only: :destroy
  resources :settings, only: :update
  resources :tweets, only: [:show, :destroy] do
    member do
      post :save
      delete :unsave
    end
    collection do
      get :fetch
      get :sweep
    end
  end
  root "homes#show"
end
