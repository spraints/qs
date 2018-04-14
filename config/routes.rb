Rails.application.routes.draw do
  root 'welcome#index'

  get    "auth/google"             => "sessions#omniauth"
  get    "auth/:provider/callback" => "sessions#create"
  delete "auth"                    => "sessions#destroy"

  metric_name_pattern = Rails.application.config.metric_name_pattern

  delete "metrics/values/:id" => "values#destroy", :as => :value
  get "metrics/:id.csv" => "metrics#export"
  resources :metrics, :constraints => { :id => metric_name_pattern }
end
