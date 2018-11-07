Rails.application.routes.draw do
  get 'test/:id/boardin/', to: 'test#boardin'

  post '/transact', to: 'parts#transact'


  devise_for :users

  resources :parts

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
