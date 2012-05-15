class HomeController < ApplicationController

  def index
    set_xpingback_header
  end

  def about
  end

  def sitemap
    respond_to do |format|
      format.xml
    end
  end

end
