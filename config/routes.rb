Rails.application.routes.draw do
  devise_for :users
  resources :orders
  resources :cart_items, only: [:create, :destroy]
  resources :carts
  resources :products do
    collection do
      get 'list', action: :list
    end
  end
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
