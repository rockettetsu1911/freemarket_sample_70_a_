Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :items, only: [:index, :new]
  resources :users, only: :show
  resources :cards, only: [:new, :show]
end
