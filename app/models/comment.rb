class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, :counter_cache => true

  has_ancestry

  attr_accessible :name, :website, :message, :parent_id

  #validates_existence_of :user, :post
  validates_presence_of :message
  validates_length_of :message, maximum: 512
  validates_format_of :website, :with => URI::regexp(%w(http https)), allow_blank: true

  before_validation do
    self.name = user.name unless user.nil?
    unless website.blank? or website.include?("http://") or website.include?("https://")
      self.website = "http://#{website}"
    end
  end

end
