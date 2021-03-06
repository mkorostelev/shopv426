Rails.application.routes.draw do
  namespace :api do
    # products
    resources :products, only: [:index, :show]

    #  user
    resource :user, only: [:create, :update]

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
    resources :gift_certificates, only: [:index, :show, :create, :update]
    resource :gift_certificates do
      resource :generate, only: :create
    end
   end

  namespace :admin do
    resources :users, only: [:update] do
      resource :balance, only: :update
    end
  end
end
