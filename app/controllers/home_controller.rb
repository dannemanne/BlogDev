class HomeController < ApplicationController

  helper_method :latest_post

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

  def acme_challenge
    if params[:challenge] == ENV['ACME_CHALLENGE']
      render plain: ENV['ACME_SECRET'], status: :ok
    else
      head :not_found
    end
  end

  private

  def latest_post
    @latest_post ||= Post.posted.recent.first
  end

end
