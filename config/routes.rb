Rails.application.routes.draw do
  resources :books
  resources :admins
  resources :customers
  resources :orders
  resources :ratings
  resources :opinions

  root 'welcome#index'
end
