class Post < ActiveRecord::Base
  STATUS_DRAFT = 0
  STATUS_POSTED = 1
  STATUS_ARCHIVED = 2

  STATUSES = { STATUS_DRAFT     => { :name => "Draft" },
               STATUS_POSTED    => { :name => "Posted" },
               STATUS_ARCHIVED  => { :name => "Archived" }
             }.freeze

  belongs_to :user
  has_many :comments
  has_many :post_tags,    dependent: :destroy
  has_many :tags,         through: :post_tags
  has_many :post_images,  dependent: :destroy
  has_many :images,       through: :post_images

  attr_writer :tag_names
  #attr_accessible :title, :body, :tag_names, :status, :allow_comments

  validates :title,     presence: true
  validates :title_url, presence: true
  validates :body,      presence: true
  validates :posted_at, presence: true,     if: Proc.new { |p| p.status == STATUS_POSTED }
  validates :status,    inclusion: { in: STATUSES.keys }

  before_validation do
    self.posted_at ||= Time.now if status == STATUS_POSTED && changes[:status].present?
    self.title_url = title.gsub(/[^A-Za-z0-9_\-]/i, "_").gsub(/_+/, "_").downcase
  end

  before_save do
    if @tag_names && @tag_names.strip != tags.map(&:name).join(", ").strip
      self.tags = @tag_names.split(",").map{ |tag| Tag.find_or_create_by(name: tag.strip) }
    end
    self.parsed_body = Kramdown::Document.new(body).to_html
    paragraph = Nokogiri::HTML.fragment(parsed_body).children.first
    self.parsed_preview = paragraph.respond_to?(:to_html) && paragraph.to_html || ""
    self.meta_description = "#{title} | #{paragraph.respond_to?(:text) && paragraph.text || ""}"[0..150]
  end

  def display_body
    parsed_body.html_safe
  end

  def display_preview
    parsed_preview.html_safe
  end

  # To param always needs to return a String!
  def to_param
    status == STATUS_DRAFT ? id.to_s : title_url
  end

  def tag_names
    @tag_names ||= tags.map(&:name).join ", "
  end

  def older_post
    @older_post ||= Post.posted.where("posted_at < ?", posted_at).order("posted_at DESC").first
  end

  def newer_post
    @newer_post ||= Post.posted.where("posted_at > ?", posted_at).order("posted_at ASC").first
  end

  def title_preview
    title.length > 40 ? "#{title[0..36]}..." : title
  end

  scope :recent, Proc.new { |limit = 5| order("posts.posted_at DESC").limit(limit) }
  scope :posted, -> { includes(:comments).where("posts.status = ?", STATUS_POSTED) }
  scope :drafts, -> { where(:status => STATUS_DRAFT) }
  scope :archive_months, -> { select(:posted_at).where(:status => STATUS_POSTED).order("1 DESC") }

end
