Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  get '/about', to: "pages#about"
  get '/test', to: "pages#test"

  resources :users, only: [:edit, :update] do
    collection do
      get 'show'
      get 'favorites', to: "users#favorites"
    end
  end

  resources :ressources do
    resources :comments, only: [:index, :create, :destroy]
  end

  resources :ressources do
    member do
      put "like", to: "ressources#like"
      put "dislike", to: "ressources#dislike"
    end
  end
  get "category", to: "ressources#category"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
