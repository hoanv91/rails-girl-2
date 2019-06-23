Rails.application.routes.draw do
  resources :orders
  resources :cart_items, only: [:create, :destroy]
  resources :carts
  resources :products
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
