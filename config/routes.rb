Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    # products
    resources :products, only: [:index, :show]

    #  user
    resource :user, only: [:create, :update]
    patch '/profile/balance' => 'users#update'
    # match '/profile/balance' => 'users#update', via: :patch

    # session
    resource :session, only: [:create, :destroy]

    #  purchases
    resources :purchases, only: [:index, :show, :create, :destroy] do
      post 'drop', on: :collection
    end
    # match '/purchases/drop' => 'purchases#destroy', via: :post

    #  orders
    resources :orders, only: [:index, :show, :create, :update] do
      resource :payment, only: :update
      # post 'payment', on: :member, to: 'payments#payment'
    end
    # payment

    # post '/orders/:id/payment' => 'payments#payment'
    # match '/orders/:id/payment' => 'orders#update', via: :post

    #  gift_certificates
    resources :gift_certificates do
    # resource :gift_certificates, only: :create do
      # resource :generate, only: :create, to: 'gift_certificates#generate'
      post 'generate', on: :collection
      # post 'generate', to: 'gift_certificates#generate'
    end
   end


end
