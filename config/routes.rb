Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  get '/about', to: "pages#about"

  resources :users, only: [:edit, :update] do
    collection do
      get 'show'
      get 'favorites', to: "users#favorites"
    end
  end

  resources :ressources do
    resources :comments, only: [:new, :create ]
  end
  # resources :comments, only: [:destroy]
  delete "comments/:id", to: "comments#destroy"

  resources :ressources do
    member do
      put "like", to: "ressources#like"
      put "dislike", to: "ressources#dislike"
    end
  end
  get "category", to: "ressources#category"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
