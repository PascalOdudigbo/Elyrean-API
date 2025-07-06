Rails.application.routes.draw do
  # get "controller_name/method_name" custom routes setup

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  resources :roles, only: [:index, :show] # Corrected 'only' syntax
  resources :users # For a full CRUD API
  resources :artists # For managing artist profile
  resources :collections # For managing collections full CRUD API
  resources :genders, only: [:index, :show] # For partial CRUD functionality
  resources :products # Full CRUD functionality for products

  resources :products do
    resources :product_variations # Full CRUD functionality for product_variations
    resources :product_images # Full NESTED CRUD functionality for product_images like # GET /products/:product_id/product_images
    resources :product_reviews
  end

  resources :discounts # Full CRUD functionality for discounts
  resources :discount_products, only: [:show, :create, :destroy] # Corrected 'only' syntax - API RCD functionality

  resources :users do
    resources :carts, only: [:show, :create] # Corrected 'only' syntax - API RC functionality
    resources :orders # For Nested resources like /users/:user_id/orders
    resources :addresses # Nested addresses under users (consistent with AddressesController)
    resources :user_wishlists, only: [:index, :create, :destroy] # POST /users/:user_id/user_wishlists/
  end

  resources :carts do
    resources :cart_items, only: [:index, :create, :update, :destroy] # Corrected 'only' syntax - API CUD functionality
  end

  resources :orders do
    resources :order_items # For Nested resources like /orders/:order_id/order_items
    resources :returns, only: [:index, :show, :create, :update]
    resources :refunds, only: [:index, :show, :create, :update]
    resources :payments, only: [:show, :create]
  end

  resources :returns do
    resources :returned_items # Nested returned_items under returns
  end


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
