class PostsController < ApplicationController
  POSTS_PER_PAGE = 5

  load_and_authorize_resource     find_by: :title_url, except: [:index, :archive]
  before_filter :find_posts,      only: [:index]
  before_filter :find_by_date,    only: [:archive]
  before_action :set_meta,        only: [:show]

  helper_method :no_of_pages, :page, :archive_date

  def archive
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @post = @post.decorate
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
    if @post.post_form(post_params, current_user).save
      flash[:notice] = 'Post successfully created!'
      if @post.post_status.is_posted?
        redirect_to @post
      else
        redirect_to draft_path(@post)
      end
    else
      render action: :new
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
      if @post.post_form(post_params, current_user).save
        format.html { redirect_to @post.post_status.is_posted? ? post_path(@post) : draft_path(@post) }
      else
        format.html { render action: :edit }
      end
      format.js
    end
  end

private
  def find_posts
    @posts = Post.posted.order('posted_at DESC').limit(POSTS_PER_PAGE).offset( (page-1) * POSTS_PER_PAGE ).decorate
  end

  def find_by_date
    @posts = Post.from_archive(params[:year], params[:month]).decorate
  end

  def post_params
    params.require(:post).permit(:title, :body, :status, :tag_names, :allow_comments)
  end

  # Helper methods
  def no_of_pages
    @_no_of_pages ||= (count = Post.posted.count) / POSTS_PER_PAGE + ( (count % POSTS_PER_PAGE) > 0 ? 1 : 0)
  end

  def page
    @_page ||= (page = (params[:page] && params[:page].to_i || 1)) <= 0 ? 1 : page
  end

  def archive_date
    Date.new(params[:year].to_i, params[:month].to_i)
  end

  def set_meta
    set_meta_tags og: {
                      title: :title,
                      description: :description,
                      site_name: :site,
                      url: post_path(@post)
                  },
                  twitter: {
                      card: 'summary',
                      title: :title,
                      description: :description,
                      site_name: :site,
                      url: post_path(@post)
                  }
  end

end
