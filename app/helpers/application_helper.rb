module ApplicationHelper

  def popular_tags(limit = 5)
    tags = Tag.order("posts_count DESC").limit(limit)
    render "partials/popular_tags", :popular_tags => tags
  end

  def archive_tag(limit = 5)
    months = Post.archive_months.group_by { |post| post.posted_at.strftime("%Y-%m") }.keys
    render "partials/archive", :archive_months => months
  end

  def thumb_url(variant)
    Rails.application.routes.url_helpers.rails_representation_url(variant, host: request.host)
  end

end
