class CommentsController < ApplicationController
  load_and_authorize_resource

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to post_path(@comment.post.to_param) }
        format.js
      else
        format.html { redirect_to post_path(@comment.post.to_param) }
        format.js
      end
    end
  end

end
