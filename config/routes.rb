Rails.application.routes.draw do

  get '/', to: 'welcome#index', as: 'home'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :posts
  resources :comments, only: [:new, :create, :edit, :update, :destroy]
  resources :categories, only: [:index, :show, :new, :create]

end
