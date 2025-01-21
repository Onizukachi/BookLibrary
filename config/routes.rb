Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :admins

  authenticated :admin do
    root to: "admin#index", as: :admin_root
  end

  # Defines the root path route ("/")
  root "home#index"

  get "admin" => "admin#index"

  namespace :admin do
    resources :orders
    resources :products do
      resources :stocks
    end
    resources :categories
  end

  resources :categories, only: [:show]
  resources :products, only: [:show]
end
