class Tag < ActiveRecord::Base
  has_many :post_tags,  dependent: :destroy
  has_many :posts,      through: :post_tags

  validates :name, presence: true,              uniqueness: true
  validates :stub, format: /\A[a-z0-9_\-]*\Z/i, uniqueness: true

  before_validation do
    self.stub = name && name.downcase.gsub(/[^a-z0-9_\-]/i, '_').gsub(/_+/, '_')
  end

  # If save failed, reset it to previous value. Otherwise path helpers
  # will generate invalid paths.
  after_rollback do
    if changes[:stub].present?
      self.stub = changes[:stub].first
    end
  end

  scope :most_used, -> { order(posts_count: :desc) }

  def to_param
    stub
  end

  def self.from_param(name)
    find_by_stub!(name)
  end
end
