Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tournaments
      resources :rounds do
        resources :matches, only: [:index]
        collection do
          get 'by_tournament/:tournament_id', to: 'rounds#by_tournament', as: 'by_tournament'
        end
        member do
          get 'calculate_standings'
        end
      end
      resources :matches do
        collection do
          get 'by_round/:round_id', to: 'matches#by_round', as: 'by_round'
        end
        member do
          put 'score_update'
          put 'lock'
          put 'unlock'
        end
      end
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
