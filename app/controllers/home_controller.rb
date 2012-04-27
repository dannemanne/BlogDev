class HomeController < ApplicationController

  def index
    set_xpingback_header
  end

  def about
  end

  def cheat_sheets
  end

  def sitemap
    respond_to do |format|
      format.xml
    end
  end

end
