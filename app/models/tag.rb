class Tag < ActiveRecord::Base
  has_many :post_tags, :dependent => :destroy
  has_many :posts, :through => :post_tags

  #attr_accessible :name
  validates_presence_of :name
  validates_format_of :stub, :with => /\A[a-z0-9_\-]*\Z/i
  validates_uniqueness_of :name, :stub

  before_validation do
    self.stub = name && name.downcase.gsub(/[^a-z0-9_\-]/i, "_").gsub(/_+/, "_")
  end

  # If save failed, reset it to previous value. Otherwise path helpers
  # will generate invalid paths.
  after_rollback do
    if changes[:stub].present?
      self.stub = changes[:stub].first
    end
  end

  def to_param
    stub
  end

  def self.from_param(name)
    find_by_stub!(name)
  end
end
