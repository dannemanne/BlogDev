class PostsController < ApplicationController
  load_and_authorize_resource     :find_by => :title_url, :except => [:index, :archive]
  before_filter :find_by_date,    :only => :archive

  def archive
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    posts_per_page = 5
    @no_of_pages = Post.posted.count / posts_per_page + ( (Post.posted.count % posts_per_page) > 0 ? 1 : 0)
    @page = params[:page] && params[:page].to_i || 1
    @page = 1 if @page <= 0
    @posts = Post.posted.order("posted_at DESC").limit(posts_per_page).offset( (@page-1) * posts_per_page )
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    set_xpingback_header
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
    if @post.save
      flash[:notice] = "Post successfully created!"
      if @post.status == Post::STATUS_POSTED
        redirect_to @post
      else
        redirect_to draft_path(@post)
      end
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
    respond_to do |format|
      if @post.update_attributes(params[:post])
        if @post.status == Post::STATUS_POSTED
          format.html { render :action => :show }
          format.js
        else
          format.html { redirect_to draft_path(@post) }
          format.js
        end
      else
        format.html { render :action => :edit }
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

  def comment
    @comment = @post.comments.build(params[:comment])
    @comment.user = current_user if current_user
    if @comment.save
      @comment = nil
    end
    respond_to do |format|
      format.html { render :action => :show  }
      format.js
    end
  end

private
  def find_by_date
    @date1 = Date.new(params[:year].to_i,params[:month].to_i)
    @date2 = Date.new(params[:year].to_i+params[:month].to_i/12,(params[:month].to_i%12)+1)
    @posts = Post.where("posted_at > ? and posted_at < ?", @date1, @date2)
  end

end
