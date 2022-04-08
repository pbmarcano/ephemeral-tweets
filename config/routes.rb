require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    mount Blazer::Engine, at: "/blazer"
    mount Sidekiq::Web, at: '/sidekiq'
    if Rails.env.development? || Rails.env.staging?
      mount LetterOpenerWeb::Engine, at: '/letter_opener'
    end
  end

  # app routes
  get "/auth/:provider/callback", to: "sessions#create"
  resource :billing, only: :show
  resource :checkout, only: :show
  resource :home, only: :show
  resource :session, only: :destroy
  resources :settings, only: :update
  resources :tweets, only: [:index, :show, :destroy] do
    resource :saves, only: [:create, :destroy]
    collection do
      get :saved
      get :fetch
      get :sweep
    end
  end
  resource :upcoming, only: :show
  root "homes#show"
end
