Rails.application.routes.draw do
  root 'welcome#index'

  get    "auth/google"             => "sessions#omniauth"
  post   "auth/:provider/callback" => "sessions#create"
  delete "auth"                    => "sessions#destroy"

  resources :metrics
end
