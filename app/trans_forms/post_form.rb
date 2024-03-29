class PostForm < ApplicationTransForm
  PROXY_ATTR = %w(
    allow_comments
    body
    parsed_body
    posted_at
    series_part
    series_title
    status
    title
  )

  set_main_model :post, proxy: { attributes: PROXY_ATTR }

  attribute :tag_names,       String,   default: proc { |f| f.post && f.post.tags.map(&:name).join(', ') }
  attr_accessor :cover

  validates :current_user,  presence: true
  validates :post,          presence: true

  transaction do
    save_post!
    save_cover!
    save_tags!
  end

private
  def save_post!
    post.attributes = {
        allow_comments: allow_comments,
        body: body,
        parsed_body: parsed_body,
        posted_at: posted_at,
        series_part: series_part,
        series_title: series_title,
        status: status,
        title: title,
    }
    post.user = current_user
    post.save!
  end

  def save_cover!
    post.cover.attach(cover) if cover.present?
  end

  def save_tags!
    # Parses +tag_names+ an assigns appropriate Tags
    post.tags = tag_names.split(',').map { |tag| Tag.find_or_create_by(name: tag.strip) }
    post.save!
  end

end
