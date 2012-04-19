class Tag < ActiveRecord::Base
  has_many :post_tags, :dependent => :destroy
  has_many :posts, :through => :post_tags

  attr_accessible :name
  validates_presence_of :name
  validates_format_of :name, :with => /\A[A-Za-z0-9_\-]*\Z/i
  validates_uniqueness_of :name

  before_validation do
    name.gsub! " ", "-"
  end

  def to_param
    name.downcase
  end

  def self.from_param(name)
    find_by_name!(name)
  end
end
