Rails.application.routes.draw do

  get '/', to: 'welcome#index', as: 'home'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :posts
  resources :comments, only: [:new, :create, :edit, :update, :destroy]
  resources :categories, only: [:index, :show, :new, :create]

  post '/posts/:id/favorite', to: 'posts#favorite'
  post '/posts/:id/up_vote', to: 'posts#up_vote'
  post '/posts/:id/down_vote', to: 'posts#down_vote'
  delete '/posts/:id/un_favorite', to: 'posts#un_favorite'
  delete '/posts/:id/revoke_vote', to: 'posts#revoke_vote'

  get '/users/:id/favorites', to: 'users#favorites', as: 'user_favorites'
  get '/users/:id/posts', to: 'users#posts', as: 'user_posts'

end
