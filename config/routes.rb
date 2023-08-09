Rails.application.routes.draw do

  get 'relationships/followings'
  get 'relationships/followers'
  devise_for :users
  root to: "homes#top"
  
  get 'home/about' => 'homes#about', as: 'about'
  resources :books, only: [:index, :show, :create, :destroy, :edit, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'search', to: 'users#search'
  end
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  
  resources :groups, only: [:new, :index, :show, :create, :edit, :update]
  
  get 'search' => 'searches#search'
  
end
