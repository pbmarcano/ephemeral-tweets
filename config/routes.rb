Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/auth/:provider/callback", to: "sessions#create"
  resource :session, only: :destroy
  resource :update_tweets, only: :show
  root "dashboard#show"
end
