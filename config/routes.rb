Rails.application.routes.draw do
  patch 'parts/transaction', to: 'parts#transaction'
  get 'expeditions/simulator', to: 'expeditions#simulator'

  devise_for :users

  resources :parts, only: [:index, :new, :create]
  get 'parts/sell/:id', to: 'parts#sell', as: "parts_sell"
  patch 'parts/salvage', to: 'parts#salvage'
  patch 'parts/sell', to: 'parts#put_in_marketplace'
  patch 'parts/equip', to: 'parts#equip'
  patch 'parts/removemkt', to: 'parts#remove_from_marketplace'


  resources :races, only: [:create, :show]

  resources :ships

  resources :players, only: [:index, :show]

  resources :expeditions, only: [ :new, :create ]




  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
