Rails.application.routes.draw do

  get '/', to: 'welcome#index', as: 'home'
  resources :users
  resources :posts
  resources :comments, only: [:new, :create, :edit, :update, :destroy]
  resources :categories, only: [:index, :show, :new, :create]
end
