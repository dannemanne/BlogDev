class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :popular_tags, :recent_posts, :archive_months

protected

  def popular_tags(limit = 5)
    Tag.order("posts_count DESC").limit(limit)
  end

  def recent_posts(limit = 5)
    Post.posted.recent(limit)
  end

  def archive_months(limit = 5)
    @archive_months = Post.archive_months.group_by { |post| post.posted_at.strftime("%Y-%m") }.keys
  end

  def set_xpingback_header
    response.headers["X-Pingback"] = pingback_server_url
  end

  def pingback_server_url
    url_for(:controller => :pingback,
      :action => :xmlrpc, :only_path => false)
  end

end
