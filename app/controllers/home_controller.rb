class HomeController < ApplicationController

  def index
    set_xpingback_header
    respond_to do |format|
      format.html
      format.js
    end
  end

  def about
    respond_to do |format|
      format.html
      format.js
    end
  end

end
