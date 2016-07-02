Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
     resources :products, only: [:index, :show]

     resource :user, only: [:create, :update]

     resource :session, only: [:create, :destroy]

     resources :purchases, only: [:index, :show, :create, :destroy]
     match '/purchases/drop' => 'purchases#destroy', via: :post

     resources :orders, only: [:index, :show, :create, :update]

     match '/profile/balance' => 'users#update', via: :patch
     match '/orders/:id/payment' => 'orders#update', via: :post
   end


end
