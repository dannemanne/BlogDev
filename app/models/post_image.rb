class PostImage < ActiveRecord::Base
  belongs_to :post
  belongs_to :image
end
