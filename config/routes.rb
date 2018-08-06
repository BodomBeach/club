Rails.application.routes.draw do
  root to:'users#home', as: 'root'
  patch 'users/:id', to:'users#update', as: 'update'
  resources :users
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as:'logout'
end
