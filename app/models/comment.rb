class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, :counter_cache => true

  validates_existence_of :user, :post
  validates_presence_of :message, :title
end