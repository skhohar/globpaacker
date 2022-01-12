Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/dashboard', to: 'pages#dashboard'
  get '/direction-test', to: 'pages#direction-test'
  get '/geolocalisation', to: 'pages#geolocalisation'

  patch '/visit-step/:id', to: "steps#visit", as: "visit_step"

  resources :navigations, only: %i[show new create] do
    resources :places, only: %i[show] do
      resources :steps, only: :create
    end

    # member do
    #   :places
    #   get '/navigation_decision', to: 'pages#navigation_decision', as: 'decision'
    #   get '/itinerary_to_nextplace', to: 'pages#itinerary_to_nextplace', as: 'itinerary'
    # end
  end

  resources :places, only: %i[new create destroy]
end
