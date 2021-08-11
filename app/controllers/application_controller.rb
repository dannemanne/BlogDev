class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied, ActiveRecord::RecordNotFound do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # Workaround to make cancan work with Rails 4 strong parameters
  before_action do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  before_action do
    set_meta_tags site: 'DanneManne', author: 'Daniel Viklund'
  end

  helper_method :recent_posts, :popular_tags, :pingback_server_url, :thumb_url, :rich_text_author

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
    "https://dannemanne.com/xmlrpc" #TODO:Fix this later. The former syntax is causing errors in devise controllers
  end

  def thumb_url(variant)
    Rails.application.routes.url_helpers.rails_representation_url(variant, host: request.host, protocol: Rails.env.production? ? 'https' : 'http')
  end

  def rich_text_author
    {
        "@type": 'Person',
        "familyName": 'Viklund',
        "givenName": 'Daniel',
        "name": 'Daniel Viklund',
        "alternateName": 'DanneManne',
        "sameAs": %w(
            https://twitter.com/dannemanne84
            https://www.linkedin.com/in/daniel-viklund-83231793/
            https://github.com/dannemanne
            https://stackoverflow.com/users/511558/dannemanne
            https://dev.to/dannemanne
            https://www.buymeacoffee.com/dannemanne
            https://hashnode.com/@dannemanne
        ),
    }
  end

end
