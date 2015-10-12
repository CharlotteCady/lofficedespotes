Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  get '/about', to: "pages#about"

  resources :users, only: [:edit, :update] do
    collection do
      get 'show'
      get 'favorites', to: "users#favorites"
      patch 'update_password'
    end
  end

# REDIRIGER VERS LA PAGE USER SHOW APRES MODIFICATIONS (USER EDIT et PASSWORD EDIT)
  # as :user do
  #   get 'users/show', :to => 'devise/registrations#edit', :as => :user_root
  # end

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
