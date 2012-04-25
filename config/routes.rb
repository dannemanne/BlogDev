Blog::Application.routes.draw do

  root :to => "home#index"
  get "about" => "home#about", :as => :about

  devise_for :users

  get "posts/:page" => "posts#index", :as => :posts_page, :constraints => { :page => /[0-9]+/ }
  resources :posts do
    post :comment, :on => :member
  end
  get "tag/:tag" => "posts#by_tag", :as => :tag
  get "tags" => "tags#index", :as => :tags
  get ":year/:month" => "posts#archive", :as => :archive, :constraints => { :year => /\d{4}/, :month => /\d{2}/ }
  resources :drafts, :only => [:index, :show, :update, :destroy]

  resources :projects, :only => [:index]

  post "xmlrpc" => "pingback#xmlrpc"

end
