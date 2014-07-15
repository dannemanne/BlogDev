class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_tags,    dependent: :destroy
  has_many :tags,         through: :post_tags
  has_many :post_images,  dependent: :destroy
  has_many :images,       through: :post_images

  attr_writer :tag_names

  validates :title,     presence: true
  validates :body,      presence: true

  handles_value_of :status, with: PostStatus

  before_save :set_attributes

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

  # To param always needs to return a String!
  def to_param
    post_status.is_draft? ? id.to_s : title_url
  end

  def post_form(attr = {}, current_user = nil)
    @post_form ||= PostForm.new_in_model(self, attr, current_user)
  end

private
  def set_attributes
    # If the post is posted, then make sure that posted_at is set
    self.posted_at ||= Time.now if post_status.is_posted?
    self.posted_at = nil if post_status.is_draft?

    # Parses title into a url-friendly format
    self.title_url = title.gsub(/[^A-Za-z0-9_\-]/i, '_').gsub(/_+/, '_').downcase

    # Parses the body into different formats to be used in different places on the site
    self.parsed_body = Kramdown::Document.new(body).to_html
    paragraph = Nokogiri::HTML.fragment(parsed_body).children.first
    self.parsed_preview = paragraph.respond_to?(:to_html) && paragraph.to_html || ''
    self.meta_description = "#{title} | #{ paragraph.respond_to?(:text) && paragraph.text || '' }"[0..150]
  end

end
