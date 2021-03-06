Hadean::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  match 'pages/featured_products' => 'pages#featured_products'
  match 'pages/brands' => 'pages#brands'
  match 'pages/new_products' => 'pages#new_products'
  match 'pages/:id' => 'pages#show_page'

  resources :payment_notifications, :only => [:create]

  match 'confirm_payment_amazon' => 'amazon_payments#confirm'

  resources :user_sessions, :only => [:new, :create, :destroy]
  #match 'admin/pages/new'   => 'admin/pages#new'

  match 'admin'   => 'admin/overviews#index'
  match 'login'   => 'user_sessions#new'
  match 'logout'  => 'user_sessions#destroy'
  match 'signup'  => 'customer/registrations#new'
  match 'admin/merchandise' => 'admin/merchandise/summary#index'
  resources :products, :only => [:index, :show, :create]

  resources :wish_items,  :only => [:index, :destroy]
  resources :states,      :only => [:index]
  resource :about,        :only => [:show]
  resources :terms,       :only => [:index]

  root :to => "welcome#index"

  namespace :customer do
    resources :registrations,   :only => [:new, :create]
    resource  :password_reset,  :only => [:new, :create, :edit, :update]
    resource  :activation,      :only => [:show]
  end

  namespace :myaccount do
    resources :messages, :only => [:index, :new, :create, :show]
    resources :orders, :only => [:index, :show]
    resources :addresses
    resources :credit_cards
    resource  :store_credit, :only => [:show]
    resource  :overview, :only => [:show, :edit, :update]
  end

  namespace :shopping do
    resources  :cart_items do
      member do
        put :move_to
      end
    end
    resource  :coupon, :only => [:show, :create]
    resources  :orders do
      member do
        get :checkout
      end
    end
    resources  :shipping_methods
    resources  :addresses do
      member do
        put :select_address
      end
    end

  end

  namespace :admin do
    resources :users
    resources :overviews, :only => [:index]

    match "help" => "help#index"

    resources :pages
    resources :emails
    resources :messages

    match 'images/update_with_variant/' => 'images#update_with_variant'
    match 'images/create_with_variant/' => 'images#create_with_variant'
    match 'images/update_with_simple_variant/' => 'images#update_with_simple_variant'
    match 'images/create_with_simple_variant/' => 'images#create_with_simple_variant'
    match 'images/update_with_fast_variant/' => 'images#update_with_fast_variant'
    match 'images/create_with_fast_variant/' => 'images#create_with_fast_variant'
    resources :images

    namespace :rma do
      resources  :orders do
        resources  :return_authorizations do
          member do
            put :complete
          end
        end
      end
      #resources  :shipments
    end

    namespace :history do
      resources  :orders, :only => [:index, :show] do
        resources  :addresses, :only => [:index, :show, :edit, :update, :new, :create]
      end
    end

    namespace :fulfillment do
      resources  :orders do
        member do
          put :create_shipment
        end
        resources  :comments
      end
      resources  :shipments do
        member do
          put :ship
        end
        resources  :addresses , :only => [:edit, :update]# This is for editing the shipment address
      end
    end
    namespace :shopping do
      resources :carts
      resources :products
      resources :users
      namespace :checkout do
        resources :billing_addresses, :only => [:index, :update, :new, :create, :select_address] do
          member do
            put :select_address
          end
        end
        resources :credit_cards
        resource  :order, :only => [:show, :update, :start_checkout_process] do
          member do
            post :start_checkout_process
          end
        end
        resources :shipping_addresses, :only => [:index, :update, :new, :create, :select_address] do
          member do
            put :select_address
          end
        end
        resources :shipping_methods, :only => [:index, :update]
      end
    end
    namespace :config do
      resources :accounts
      resources :countries, :only => [:index, :update, :destroy]
      resources :overviews
      resources :shipping_categories
      resources :shipping_rates
      resources :shipping_methods
      resources :shipping_zones
      resources :tax_rates
      resources :tax_categories
    end

    namespace :generic do
      resources :coupons
      resources :deals
      resources :sales
      resources  :store_credits, :inly => [:index, :show, :update, :edit]
    end
    namespace :inventory do
      resources :suppliers
      resources :overviews
      resources :purchase_orders
      resources :receivings
      resources :adjustments
    end

    namespace :merchandise do
      namespace :images do
        resources :products
      end
      resources :properties
      resources :prototypes
      resources :brands
      resources :product_types
      resources :prototype_properties

      namespace :changes do
        resources :products do
          resource :property,          :only => [:edit, :update]
        end
      end

      namespace :wizards do
        resources :brands,              :only => [:index, :create, :update]
        resources :products,            :only => [:new, :create]
        resources :properties,          :only => [:index, :create, :update]
        resources :prototypes,          :only => [:update]
        resources :tax_categories,        :only => [:index, :create, :update]
        resources :shipping_categories, :only => [:index, :create, :update]
        resources :product_types,       :only => [:index, :create, :update]
      end

      namespace :multi do
        resources :products do
          resource :variant,      :only => [:edit, :update]
          match 'variants/create' => 'variants#create'
          match 'variants/variant_image' => 'variants#variant_image'
        end
      end
      resources :simple_products, :only => [:new, :edit, :create, :update] do
        member do
          get :description_form
          put :description
          get :property_form
          put :property
          get :variant_form
          put :variant
          post :create_variant
          get :variant_image
          get :inventory
          get :images_form
          delete :destroy_image
          put :price_for_all
        end
      end
      resources :fast_products, :only => [:edit, :update] do
        member do
          post :create_variant
          get :variant_image
          put :price_for_all
        end
      end
      resources :products do
        member do
          get :add_properties
          put :activate
          post :price_for_all
        end
        resources :variants
      end
      namespace :products do
        resources :descriptions, :only => [:edit, :update]
      end
    end
    namespace :document do
      resources :invoices
    end
  end
end