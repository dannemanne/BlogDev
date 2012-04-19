class PostsController < ApplicationController
  load_and_authorize_resource     :find_by => :title_url, :except => [:by_tag, :archive]
  before_filter :find_by_tag,     :only => :by_tag
  before_filter :find_by_date,    :only => :archive

  def by_tag
    respond_to do |format|
      format.html
      format.js
    end
  end

  def archive
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
        redirect_to edit_post_path(@post)
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
    if @post.update_attributes(params[:post])
      if @post.status == Post::STATUS_POSTED
        respond_to do |format|
          format.html { render :action => :show }
          format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to draft_path(@post) }
          format.js
        end
      end
    else
      respond_to do |format|
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
    if @comment = @post.comments.create(params[:comment])
      @comment = nil
    end
    respond_to do |format|
      format.html { render :action => :show  }
      format.js
    end
  end

private
#  def load_drafts
#    if user_signed_in?
#      @posts = current_user.posts.drafts
#    else
#      redirect_to root_path
#    end
#  end

  def find_by_tag
    @tag = Tag.from_param(params[:tag])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def find_by_date
    @date1 = Date.new(params[:year].to_i,params[:month].to_i)
    @date2 = Date.new(params[:year].to_i+params[:month].to_i/12,(params[:month].to_i%12)+1)
    @posts = Post.where("posted_at > ? and posted_at < ?", @date1, @date2)
  end

end
