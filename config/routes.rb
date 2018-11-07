Rails.application.routes.draw do
  get 'test/:id/boardin/', to: 'test#boardin'

  patch 'parts/transaction', to: 'parts#transaction'

  post 'boardin', to: 'test#boardin_submit'


  devise_for :users

  resources :parts





  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
