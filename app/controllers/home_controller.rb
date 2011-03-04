class HomeController < ApplicationController

  def index
    @posts = Post.posted.recent
    respond_to do |format|
      format.html
      format.js
    end
  end

end
