class Image < ApplicationRecord
  belongs_to :user
  has_many :post_images,  dependent: :destroy
  has_many :posts,        through: :post_images

  # has_attached_file :image
  # validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
