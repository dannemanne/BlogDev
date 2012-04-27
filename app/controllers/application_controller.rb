class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  helper_method :recent_posts, :pingback_server_url

protected

  def recent_posts(limit = 5)
    Post.posted.recent(limit)
  end

  def set_xpingback_header
    response.headers["X-Pingback"] = pingback_server_url
  end

  def pingback_server_url
    url_for(:controller => :pingback,
      :action => :xmlrpc, :only_path => false)
  end

end
