Rails.application.routes.draw do
  namespace :api do
    # products
    resources :products, only: [:index, :show]

    #  user
    resources :users, only: :update
    resource :user, only: [:create, :update] do
      resource :balance, only: :update
    end
    # patch '/profile/balance' => 'users#update'

    # session
    resource :session, only: [:create, :destroy]

    #  purchases
    resources :purchases, only: [:index, :show, :create]
    resource :purchases, only: [:create, :destroy] do
      resource :current_purchase, only: [:create, :destroy]
    end

    #  orders
    resources :orders, only: [:index, :show, :create, :update] do
      resource :payment, only: :update
    end

    #  gift_certificates
    resources :gift_certificates
    resource :gift_certificates do
      resource :generate, only: :create
    end
   end


end
