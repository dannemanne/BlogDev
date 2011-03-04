class PostsController < ApplicationController
  load_and_authorize_resource

  uses_tiny_mce :only => [:new, :create]

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @post.attributes = params[:post]
    @post.user = current_user
    @post.posted = params[:post_button]
    if @post.save
      flash[:notice] = "Post successfully created!"
      render :action => :show
    else
      render :action => :new
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update

  end

  def destroy

  end

end
