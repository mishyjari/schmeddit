Rails.application.routes.draw do
  resources :welcome, only: :index
  resources :users
  resources :posts
  resources :comments, only: [:new, :create, :edit, :update, :destroy]
  resources :categories, only: [:index, :show, :new, :create]
end
