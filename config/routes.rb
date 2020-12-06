Rails.application.routes.draw do
  get 'comments/new'
  get 'comments/create'
  get 'topics/new'
  get  'sessions/new'
  get  'users/new'
  get  'pages/index'
  root 'pages#index'

  get  'pages/help'

  resources :users
  resources :topics
  resources :favorites
  resources :comments

  get   '/login',   to: 'sessions#new'
  post  '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  delete '/favorites', to:'favorites#destroy'
end
