Rails.application.routes.draw do
  resources :books
  resources :admins
  resources :customers
  resources :orders
  resources :ratings
  resources :opinions

  get '/signup', to: 'customers#new'
  post '/signup', to: 'customers#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/search', to: 'books#search'
  root 'welcome#index'
end
