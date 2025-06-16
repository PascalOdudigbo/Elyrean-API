Rails.application.routes.draw do
  get "products/index"
  get "products/show"
  get "products/create"
  get "products/update"
  get "products/destroy"
  get "categories/index"
  get "categories/show"
  get "categories/create"
  get "categories/update"
  get "categories/destroy"
  get "genders/index"
  get "genders/show"
  get "collections/index"
  get "collections/show"
  get "collections/create"
  get "collections/update"
  get "collections/destroy"
  get "addresses/index"
  get "addresses/show"
  get "addresses/create"
  get "addresses/update"
  get "addresses/destroy"
  get "artists/index"
  get "artists/show"
  get "artists/create"
  get "artists/update"
  get "artists/destroy"
  get "users/index"
  get "users/show"
  get "users/create"
  get "users/update"
  get "users/destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :roles, only[:index, :show]
  resources :users # For a full CRUD API
  resources :artists # For managing artist profile
  resources :addresses # For managing address full CRUD API
  resources :collections # For managing collections full CRUD API 
  resources :genders, only[:index, :show] # For partial CRUD functionality
  resources :products # Full CRUD functionality for products
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
