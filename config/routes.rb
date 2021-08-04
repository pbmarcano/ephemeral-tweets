Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/auth/:provider/callback", to: "sessions#create"
  resource :session, only: :destroy
  resources :settings, only: :update
  resources :tweets, only: :destroy do
    collection do
      get 'update_all'
    end
  end
  root "dashboard#show"
end
