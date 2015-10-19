Rails.application.routes.draw do

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  ActiveAdmin.routes(self)
  get '/a-propos', to: "pages#about", as: '/about'
  get "/categorie", to: "ressources#category", as: "/category"
  post "category", to: "ressources#category"
  # get "/guide-de-l-emploi", to: "ressources#index", as: "/ressources"

  resources :users, only: [:edit, :update] do
    collection do
      get 'show'
      get 'favorites', to: "users#favorites"
      patch 'update_password'
    end
  end

# REDIRIGER VERS LA PAGE USER SHOW APRES MODIFICATIONS (USER EDIT et PASSWORD EDIT)
  as :user do
    get 'users/show', :to => 'devise/registrations#edit', :as => :user_root
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

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
