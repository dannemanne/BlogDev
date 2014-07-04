class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_tags,    dependent: :destroy
  has_many :tags,         through: :post_tags
  has_many :post_images,  dependent: :destroy
  has_many :images,       through: :post_images

  attr_writer :tag_names

  validates :title,     presence: true
  validates :title_url, presence: true
  validates :body,      presence: true
  validates :posted_at, presence: true,     if: Proc.new { |p| p.post_status.is_posted? }

  handles_value_of :status, with: PostStatus

  before_validation do
    self.posted_at ||= Time.now if post_status.is_posted?
    self.posted_at = nil if post_status.is_draft?
    self.title_url = title.gsub(/[^A-Za-z0-9_\-]/i, '_').gsub(/_+/, '_').downcase
  end

  before_save do
    if @tag_names && @tag_names.strip != tags.map(&:name).join(', ').strip
      self.tags = @tag_names.split(',').map{ |tag| Tag.find_or_create_by(name: tag.strip) }
    end
    self.parsed_body = Kramdown::Document.new(body).to_html
    paragraph = Nokogiri::HTML.fragment(parsed_body).children.first
    self.parsed_preview = paragraph.respond_to?(:to_html) && paragraph.to_html || ''
    self.meta_description = "#{title} | #{ paragraph.respond_to?(:text) && paragraph.text || '' }"[0..150]
  end

  scope :posted, -> { includes(:comments).where('posts.status = ?', PostStatus::POSTED) }
  scope :drafts, -> { where(status: PostStatus::DRAFT) }
  scope :archive_months, -> { select(:posted_at).where(status: PostStatus::POSTED).order('1 DESC') }

  def self.from_archive(year, month)
    date1 = Date.new(year.to_i,month.to_i)
    date2 = Date.new(year.to_i+month.to_i/12,(month.to_i%12)+1)
    where('posted_at > ? and posted_at < ?', date1, date2)
  end

  def self.recent(limit = 5)
    order('posts.posted_at DESC').limit(limit)
  end

  def display_body
    parsed_body.html_safe
  end

  def display_preview
    parsed_preview.html_safe
  end

  # To param always needs to return a String!
  def to_param
    post_status.is_draft? ? id.to_s : title_url
  end

  def tag_names
    @tag_names ||= tags.map(&:name).join ', '
  end

  def older_post
    @older_post ||= Post.posted.where('posted_at < ?', posted_at).order('posted_at DESC').first
  end

  def newer_post
    @newer_post ||= Post.posted.where('posted_at > ?', posted_at).order('posted_at ASC').first
  end

  def title_preview
    title.length > 40 ? "#{title[0..36]}..." : title
  end

end
