Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :api_keys, only: [:index, :create, :destroy]
  resources :tables
  resources :league_days
  resources :leagues
end
