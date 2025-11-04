Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :tasks, only: [:index, :create]
  root "tasks#index"
end
