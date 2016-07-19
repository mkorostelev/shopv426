Rails.application.routes.draw do
  namespace :api do
    # products
    resources :products, only: [:index, :show]

    #  user
    resource :user, only: [:create, :update]
    patch '/profile/balance' => 'users#update'

    # session
    resource :session, only: [:create, :destroy]

    #  purchases
    resources :purchases, only: [:index, :show, :create, :destroy] do
      post 'drop', on: :collection
    end

    #  orders
    resources :orders, only: [:index, :show, :create, :update] do
      resource :payment, only: :update
      get 'check', on: :member
    end

    #  gift_certificates
    resources :gift_certificates do
      post 'generate', on: :collection
    end
   end


end
