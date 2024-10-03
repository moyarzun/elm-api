Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      resources :matches
      resources :players
      resources :users
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: proc { [200, {}, ['API is running']] }
  resources :api_keys, only: %i[index create destroy]
end
