Rails.application.routes.draw do
  get 'ships/show'
  get 'ships/edit'
  get 'ships/update'
  get 'parts/index'
  get 'parts/show'
  get 'parts/new'
  get 'parts/create'
  get 'parts/edit'
  get 'parts/update'
  get 'parts/transaction'
  get 'parts/destroy'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
