Rails.application.routes.draw do
  get 'topics/new'
  get  'sessions/new'
  get  'users/new'
  get  'pages/index'
  root 'pages#index'

  get  'pages/help'

  resources :users
  resources :topics
  resources :favorites

  get   '/login',   to: 'sessions#new'
  post  '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  delete '/favorites', to:'favorites#destroy'
end
