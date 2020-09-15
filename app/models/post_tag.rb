class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag, :counter_cache => :posts_count

  validates_presence_of :post_id, :tag_id
  validates_uniqueness_of :post_id, :scope => :tag_id
end
