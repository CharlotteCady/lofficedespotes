Rails.application.routes.draw do

  mount ForestLiana::Engine => '/forest'
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  ActiveAdmin.routes(self)
  get '/a-propos', to: "pages#about", as: '/about'
  get '/contact', to: "pages#contact"
  get '/comment-cela-marche', to: "pages#how", as: '/how'
  get "/categorie", to: "ressources#category", as: "/category"
  post "category", to: "ressources#category"
  get "/blog", to: "articles#category"
  post "category", to: "articles#category"
  get '/mentions-legales', to: "pages#mentions_legales"
  get '/pro', to: "pages#pro"
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:edit, :update] do
    collection do
      get 'show'
      get 'favorites', to: "users#favorites"
      get 'matching', to: "users#matching"
      get 'offer', to: "users#offer"
      get 'event', to: "users#event"
      patch 'update_password'
    end
  end

# REDIRIGER VERS LA PAGE USER SHOW APRES MODIFICATIONS (USER EDIT et PASSWORD EDIT)
  # as :user do
  #   get 'users/show', :to => 'devise/registrations#edit', :as => :user_root
  #   # get 'users/sign_in', :to => 'devise/sessions#create'
  # end

  namespace :user do
    root 'users#show' # creates user_root_path
  end

  resources :ressources do
    resources :comments, only: [:index, :create, :destroy]
    member do
      get "like", to: "ressources#like"
      get "dislike", to: "ressources#dislike"
    end
  end

  resources :articles
  resources :events do 
    member do
      get "approved", to: "events#approved"
    end
  end

  # Sitemap pour les robots
  get '/sitemap.xml.gz', to: redirect("http://#{ ENV.fetch('S3_BUCKET_NAME') }.s3.amazonaws.com/sitemaps/sitemap.xml.gz")

  post '/api/stats/age_repartition' => 'stats#age_repartition'


  # resources :ressources do
  #   member do
  #     put "like", to: "ressources#like"
  #     put "dislike", to: "ressources#dislike"
  #   end
  # end
end
