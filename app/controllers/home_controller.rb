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

  def acme_challenge
    if params[:challenge] == ENV['ACME_CHALLENGE']
      render text: ENV['ACME_SECRET'], status: :ok
    else
      head :not_found
    end
  end

end
