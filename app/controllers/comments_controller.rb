class CommentsController < ApplicationController
  load_and_authorize_resource

  def spam
    @comment.no_follow = true
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@comment.post) }
        format.js
      else
        format.html { redirect_to post_path(@comment.post) }
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to post_path(@comment.post) }
        format.js
      else
        format.html { redirect_to post_path(@comment.post) }
        format.js
      end
    end
  end

end
