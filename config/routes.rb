Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root 'items#index'

  resources :items do
    member do
      get  'purchase'=>  'items#purchase', as: 'purchase'
      patch 'pay'=>   'items#pay', as: 'pay'
      get 'done'=>  'items#done', as: 'done'
    end
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    resources :users do
      resources :likes, only: [:create, :destroy]
    end
  end

  resources :comments, only: [:create, :update]
  
  resources :users, only: :show
  resources :users do
    resources :addresses, only: [:edit, :update]
  end
  resources :likes, only: :index
  resources :cards, only: [:new, :create, :show, :destroy] 

  get '/tags/:name', to: 'items#tag', as: 'tag'
end
