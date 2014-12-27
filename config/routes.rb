Rails.application.routes.draw do
  root 'welcome#index'

  get    "auth/google"             => "sessions#omniauth"
  get    "auth/:provider/callback" => "sessions#create"
  delete "auth"                    => "sessions#destroy"

  resources :metrics, :constraints => { :id => /.*/ }
end
