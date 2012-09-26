class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied, ActiveRecord::RecordNotFound do |exception|
    redirect_to root_url, :alert => exception.message
  end

  helper_method :recent_posts, :recent_comments, :pingback_server_url

protected

  def recent_posts(limit = 5)
    Post.posted.recent(limit)
  end

  def recent_comments(limit = 5)
    Comment.recent(limit)
  end

  def set_xpingback_header
    response.headers["X-Pingback"] = pingback_server_url
  end

  def pingback_server_url
    #url_for(:controller => :pingback,
#      :action => :xmlrpc, :only_path => false)
    "http://dannemanne.com/xmlrpc" #TODO:Fix this later. The former syntax is causing errors in devise controllers
  end

end
