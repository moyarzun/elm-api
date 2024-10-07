Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :matches
      resources :players
      resources :player_matches
      resources :users
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: proc { [200, {}, ['API is running']] }
  resources :api_keys, only: %i[index create destroy]
end
