class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags,    dependent: :destroy
  has_many :tags,         through: :post_tags
  # has_many :post_images,  dependent: :destroy
  # has_many :images,       through: :post_images
  has_one_attached :cover

  # Because of CanCan automatic resource instances, we
  # need to define this attribute here. Fix later!
  attr_writer :tag_names

  validates :title,     presence: true
  validates :body,      presence: true

  handles_value_of :status, with: PostStatus

  before_save :set_attributes

  scope :posted, -> { where('posts.status = ?', PostStatus::POSTED) }
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

  def self.each_year_and_month(&block)
    year_months = archive_months.select(:updated_at).each_with_object({}) { |post, acc|
      year_month = post.posted_at.strftime("%Y-%m").split('-')
      acc[year_month] = [acc[year_month], post.updated_at].compact.max
    }

    year_months.each_pair do |(year, month), last_updated_at|
      block.call(year, month, last_updated_at)
    end
  end

  # To param always needs to return a String!
  def to_param
    post_status.is_draft? ? id.to_s : title_url
  end

  def post_form(attr = {}, current_user = nil)
    @post_form ||= PostForm.new_in_model(self, attr, current_user)
  end

  def display_series_part
    series_part.presence && "Part #{series_part}"
  end

  def display_series
    [series_title, display_series_part].reject(&:blank?).join(' - ')
  end

  def full_title
    [display_series, title].reject(&:blank?).join(': ')
  end

  def parse_body
    Kramdown::Document.new(body).to_html
  end

private
  def set_attributes
    # If the post is posted, then make sure that posted_at is set
    self.posted_at ||= Time.now if post_status.is_posted?
    self.posted_at = nil if post_status.is_draft?

    # Parses title into a url-friendly format
    self.title_url = [series_title, display_series_part, title].reject(&:blank?).join(' ').gsub(/[^A-Za-z0-9_\-]/i, '_').gsub(/_+/, '_').downcase

    # Parses the body into different formats to be used in different places on the site
    paragraph = Nokogiri::HTML.fragment(parse_body).children.first
    self.parsed_preview = paragraph.respond_to?(:to_html) && paragraph.to_html || ''
    self.meta_description = "#{ paragraph.respond_to?(:text) && paragraph.text || '' }"[0..150]
  end

end
