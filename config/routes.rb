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
  delete '/admin_logout', to: 'admins#destroy'
  delete '/logout', to: 'sessions#destroy'
  get '/search', to: 'books#search'
  get '/find', to: 'books#find'
  post '/add_to_cart', to: 'books#add_to_cart'
  get '/cart', to: 'books#cart'
  post 'subtract_from_qty', to: 'books#subt ract_from_qty'
  post 'add_to_qty', to: 'books#add_to_qty'
  post 'back', to: 'books#back'
  post 'delete_from_cart', to: 'books#delete_from_cart'
  get '/login/admin', to: 'admins#login'
  root 'welcome#index'
end
