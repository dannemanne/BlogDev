class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, :counter_cache => true

  has_ancestry

  attr_accessible :title, :message, :parent_id

  #validates_existence_of :user, :post
  validates_presence_of :message, :title
  validates_length_of :message, maximum: 255
end