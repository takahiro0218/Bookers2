Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"
  
  get 'homes/about' => 'homes#about', as: 'about'
  resources :books, only: [:new, :index, :show, :create, :destroy, :edit, :update]
  resources :users, only: [:index, :show, :edit, :update]
  
end
