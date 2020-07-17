Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'profile_edit', to: 'users/registrations#profile_edit'
    patch 'profile_update', to: 'users/registrations#profile_update'
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
      get 'search'
    end
    resources :users do
      resources :likes, only: [:create, :destroy]
    end
  end

  resources :comments, only: [:create, :update]
  
  resources :users, only: :show
  resources :users do
    resources :addresses, only: [:edit, :update]
    get 'sell_list'=>  'items#sell_list', as: 'sell_list'
    get 'buy_list'=>  'items#buy_list', as: 'buy_list'
  end
  resources :likes, only: :index
  resources :cards, only: [:new, :create, :show, :destroy] 

  get '/tags/:name', to: 'items#tag', as: 'tag'
end
