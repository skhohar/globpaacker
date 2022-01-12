Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/dashboard', to: 'pages#dashboard'
  get '/direction-test', to: 'pages#direction-test'
  get '/geolocalisation', to: 'pages#geolocalisation'

  resources :navigations, only: %i[show new create] do
    resources :places, only: %i[show] do
      resources :steps, only: :create
      member do
        patch :visited, as: 'visited'
      end
    end

    # member do
    #   :places
    #   get '/navigation_decision', to: 'pages#navigation_decision', as: 'decision'
    #   get '/itinerary_to_nextplace', to: 'pages#itinerary_to_nextplace', as: 'itinerary'
    # end
  end

  resources :places, only: %i[new create destroy]
end
