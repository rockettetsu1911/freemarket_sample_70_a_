Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  } 

  root 'items#index'

  resources :items, only: [:index, :new, :show, :create] do
    member do
      get  'purchase'=>  'items#purchase', as: 'purchase'
      patch 'pay'=>   'items#pay', as: 'pay'
      get 'done'=>  'items#done', as: 'done'
    end
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  
  post 'items/new', to: 'items#create', as: 'item_new'
  resources :users, only: :show
  resources :cards, only: [:new, :create, :show, :destroy] 
  resources :users do
    resources :addresses, only: [:new, :create]
  end
  resources :purchases, except: [:index, :new, :create, :show, :edit, :update, :destroy] do
    member do
      get 'confirm'
      #Todo: 購入完了ページなどが以下に追加される
    end
  end
end
  


