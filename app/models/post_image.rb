class PostImage < ApplicationRecord
  belongs_to :post
  belongs_to :image
end
