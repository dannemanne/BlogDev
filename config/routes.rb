Blog::Application.routes.draw do

  root :to => "home#index"
  devise_for :users

  get "posts/:page" => "posts#index", :as => :posts_page, :constraints => { :page => /[0-9]+/ }
  get ":year/:month" => "posts#archive", :as => :archive, :constraints => { :year => /\d{4}/, :month => /\d{2}/ }
  resources :posts do
    post :comment, :on => :member
  end

  resources :tags, :except => [:new, :create]
  resources :drafts, :only => [:index, :show, :update, :destroy]
  resources :projects, :only => [:index]

  get "about" => "home#about", :as => :about
  post "xmlrpc" => "pingback#xmlrpc"

end
