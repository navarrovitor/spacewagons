Rails.application.routes.draw do
  patch 'parts/transaction', to: 'parts#transaction'
  get 'expeditions/simulator', to: 'expeditions#simulator'

  devise_for :users

  resources :parts, only: [:index, :new, :create]
  get 'parts/sell/:id', to: 'parts#sell', as: "parts_sell"
  patch 'parts/salvage', to: 'parts#salvage'
  patch 'parts/sell', to: 'layers/18parts#put_in_marketplace'
  patch 'parts/equip', to: 'parts#equip'
  patch 'parts/removemkt', to: 'parts#remove_from_marketplace'

  # Access this URL to run a race
  get 'runracexxlw', to: 'races#create'
  # ---------------
  get 'races/presentation', to: 'races#presentation'

  resources :ships

  resources :players, only: [:index, :show, :edit, :update]

  resources :photos, only: [:new, :create, :edit, :update]

  resources :expeditions, only: [ :new, :create ]

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
