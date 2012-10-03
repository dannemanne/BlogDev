class CommentsController < ApplicationController
  load_and_authorize_resource

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to drafts_path }
        format.js
      else
        format.html { redirect_to drafts_path }
        format.js
      end
    end
  end

end
