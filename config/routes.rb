Rails.application.routes.draw do
  resources :reviews
  resources :trips
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "application#home"

   resources :users, only: [:new, :show] do
    # nested resource for trips
     resources :trips, only: [:show, :index]
   end


    # nested resource for reviews
    resources :users, only: [:new, :show] do
      resources :reviews, only: [:new, :edit, :show, :index]
   end
  resources :users
  resources :meals
  resources :orders, only: [:new, :destroy]

  get '/auth/facebook/callback' => 'sessions#create'

  get '/most_popular', to: 'meals#most_popular'

  get '/signin', to: 'sessions#signin'
  post '/signin', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

   get '/add_meal', to: 'orders#add_meal'
  get'/checkout', to: 'trips#checkout'
end
