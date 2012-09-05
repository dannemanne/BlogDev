class Image < ActiveRecord::Base
  belongs_to :user
  has_many :post_images,  dependent: :destroy
  has_many :posts,        through: :post_images

  has_attached_file :image

end
