Rails.application.routes.draw do

  root :to => "home#index"
  devise_for :users

  resource :profiles

  get "posts/:page" => "posts#index", :as => :posts_page, :constraints => { :page => /[0-9]+/ }
  get ":year/:month" => "posts#archive", :as => :archive, :constraints => { :year => /\d{4}/, :month => /\d{2}/ }
  resources :posts

  resources :tags, :except => [:new, :create]
  resources :drafts, :only => [:index, :show, :update, :destroy]
  resources :projects, :only => [:index]
  resources :cheat_sheets, :except => :show

  get "about" => "home#about", :as => :about
  post "xmlrpc" => "pingback#xmlrpc"
  get "sitemap" => "home#sitemap"

  get "tag/:tagname" => redirect("/tags/%{tagname}")

  get ".well-known/acme-challenge/:challenge", to: "home#acme_challenge"

  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unacceptable'
  get '/500', to: 'errors#internal_error'

end
