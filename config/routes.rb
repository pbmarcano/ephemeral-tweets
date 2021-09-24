require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # admin & development routes
  # Sidekiq basic auth for production 
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_AUTH_USERNAME"])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_AUTH_PASSWORD"]))
  end if Rails.env.production? || Rails.env.staging?
  mount Blazer::Engine, at: "blazer"
  mount Sidekiq::Web, at: '/sidekiq'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development? || Rails.env.staging?

  # app routes
  get "/auth/:provider/callback", to: "sessions#create"
  resource :billing, only: :show
  resource :checkout, only: :show
  resource :dashboard, only: :show
  resource :home, only: :show
  resource :session, only: :destroy
  resources :settings, only: :update
  resources :tweets, only: [:show, :destroy] do
    collection do
      get :fetch
    end
  end
  root "homes#show"
end
