Blog::Application.routes.draw do

  root :to => "home#index"

  devise_for :users

  resources :posts, :except => :index do
    post :comment, :on => :member
  end
  get "tag/:tag" => "posts#by_tag", :as => :tag
  get ":year/:month" => "posts#archive", :as => :archive, :constraints => { :year => /\d{4}/, :month => /\d{2}/ }
  resources :drafts, :only => [:index, :show, :update, :destroy]

  resources :projects, :only => [:index]

end
