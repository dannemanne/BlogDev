class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied, ActiveRecord::RecordNotFound do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # Workaround to make cancan work with Rails 4 strong parameters
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  helper_method :recent_posts, :popular_tags, :pingback_server_url

protected

  def recent_posts(limit = 5)
    Post.posted.recent(limit).decorate
  end

  def popular_tags
    Tag.most_used.limit(10)
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
