Rails.application.routes.draw do
  root 'welcome#index'

  get    "auth/google"             => "sessions#omniauth"
  get    "auth/:provider/callback" => "sessions#create"
  delete "auth"                    => "sessions#destroy"

  delete "metrics/values/:id" => "values#destroy", :as => :value
  resources :metrics, :constraints => { :id => /.*/ }
end
