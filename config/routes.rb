Rails.application.routes.draw do
  patch 'parts/transaction', to: 'parts#transaction'
  get 'expeditions/simulator', to: 'expeditions#simulator'

  devise_for :users

  resources :parts, only: [:index, :new, :create]

  resources :ships

  resources :players, only: :index

  resources :expeditions, only: [ :new, :create ]




  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
