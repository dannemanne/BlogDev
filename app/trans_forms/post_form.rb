class PostForm < ApplicationTransForm
  set_main_model :post, proxy: { attributes: %w(title body status allow_comments) }

  attribute :tag_names,       String,   default: proc { |f| f.post.tags.map(&:name).join(', ') }

  validates :current_user,  presence: true
  validates :post,          presence: true

  transaction do
    post.attributes = { title: title, body: body, status: status, allow_comments: allow_comments }
    post.user = current_user
    post.save!

    # Parses +tag_names+ an assigns appropriate Tags
    post.tags = tag_names.split(',').map { |tag| Tag.find_or_create_by(name: tag.strip) }
    post.save!
  end

end
