class DraftsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_posts, only: :index
  before_filter :load_post,  except: :index

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
    if @post.post_form(post_params, current_user).save
      if @post.post_status.is_posted?
        respond_to do |format|
          format.html { redirect_to post_path(@post) }
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
        format.html { render action: :show }
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
    @posts = current_user.posts.drafts.decorate
  end

  def load_post
    @post = current_user.posts.drafts.find(params[:id])
    authorize! params[:action], @post
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit(:title, :body, :status, :tag_names, :allow_comments)
  end

end
