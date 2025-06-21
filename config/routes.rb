Rails.application.routes.draw do
  get "cart_items/create"
  get "cart_items/update"
  get "cart_items/destroy"
  get "carts/show"
  get "carts/create"
  get "product_reviews/index"
  get "product_reviews/show"
  get "product_reviews/create"
  get "product_reviews/update"
  get "product_reviews/destroy"
  get "discount_products/show"
  get "discount_products/create"
  get "discount_products/destroy"
  get "discounts/index"
  get "discounts/show"
  get "discounts/create"
  get "discounts/update"
  get "discounts/destroy"
  get "product_images/index"
  get "product_images/show"
  get "product_images/create"
  get "product_images/update"
  get "product_images/destroy"
  get "product_variations/index"
  get "product_variations/show"
  get "product_variations/create"
  get "product_variations/update"
  get "product_variations/destroy"
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
  resources :product_variations # Full CRUD functionality for product_variations
  resources :product_images # Full CRUD functionality for product_images
  resources :discounts # Full CRUD functionality for discounts
  resources :discount_products, only[:show, :create, :destroy] #API RCD functionality
  resources :product_reviews
  resources :carts, only[:show, :create] #API RC functionality
  resources :cart_items, only[:create, :update, :destroy] #API CUD functionality

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
