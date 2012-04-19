class DraftsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_posts, :only => :index
  before_filter :load_post,  :except => :index

  def index
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @post.update_attributes(params[:post])
      if @post.status == Post::STATUS_POSTED
        respond_to do |format|
          format.html { redirect_to post_path(@post) }
          format.js
        end
      else
        respond_to do |format|
          format.html { render :action => :show }
          format.js
        end
      end
    else
      respond_to do |format|
        format.html { render :action => :show }
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @post.destroy
        format.html { redirect_to drafts_path }
        format.js
      else
        format.html { redirect_to drafts_path }
        format.js
      end
    end
  end

private
  def load_posts
    @posts = current_user.posts.drafts
  end

  def load_post
    @post = current_user.posts.drafts.find(params[:id])
    authorize! params[:action], @post
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

end