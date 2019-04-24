Rails.application.routes.draw do
  # Defines root path as index action from store controller
  # Create 'store_index_path' and 'store_index_url' accessor methods, enabling existing code/tests to work correctly
  root 'store#index', as: 'store_index'
  #get 'store/index'

  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
