class PostDecorator < Draper::Decorator
  delegate_all

  def title_preview
    title.length > 40 ? "#{title[0..36]}..." : title
  end

  def display_body
    body
  end

  def display_preview
    parsed_preview.html_safe
  end

  def tag_names
    @tag_names ||= tags.map(&:name).join ', '
  end

  def older_post
    @older_post ||= (p = Post.posted.where('posted_at < ?', posted_at).order('posted_at DESC').first) && p.decorate
  end

  def newer_post
    @newer_post ||= (p = Post.posted.where('posted_at > ?', posted_at).order('posted_at ASC').first) && p.decorate
  end

end
