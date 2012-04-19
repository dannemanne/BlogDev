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
  has_many :post_tags, :dependent => :destroy
  has_many :tags, :through => :post_tags

  attr_writer :tag_names
  attr_accessible :title, :body, :tag_names, :status

  validates_presence_of :title, :title_url, :body
  validates_presence_of :posted_at, :if => Proc.new { |post| post.status == STATUS_POSTED }
  validates_inclusion_of :status, :in => STATUSES.keys

  before_validation do
    self.posted_at ||= Time.now if status == STATUS_POSTED && changes[:status].present?
    self.title_url = title.gsub(/[^A-Za-z0-9_\-]/i, "_").gsub(/_+/, "_").downcase
  end

  before_save do
    if @tag_names && @tag_names != tags.map(&:name).join(" ")
      self.tags = @tag_names.split(" ").map{ |tag| Tag.find_or_create_by_name(tag) }
    end
  end

  def display_body
    Kramdown::Document.new(body).to_html.html_safe
  end

  def to_param
    status == STATUS_DRAFT ? id : title_url
  end

  def tag_names
    @tag_names ||= tags.map(&:name).join " "
  end

  # Only used when the scope archive_months has been called
  def archive_date
    if year_month
      @archive_date ||= Date.new(*year_month.split("-").map(&:to_i))
    else
      nil
    end
  end

  def display_archive_date
    archive_date && archive_date.strftime("%B %Y")
  end

  def archive_year
    archive_date && archive_date.year
  end

  def archive_month
    @archive_month ||= archive_date && archive_date.month
    @archive_month > 9 ? @archive_month : "0#{@archive_month}"
  end

  scope :recent, Proc.new { |limit = 5| order("posts.posted_at DESC").limit(limit) }
  scope :posted, includes(:comments).where("posts.status = ?", STATUS_POSTED)
  scope :drafts, where(:status => STATUS_DRAFT)
  scope :archive_months, Proc.new { |limit = 5|
    select("DISTINCT date_format(posted_at, '%Y-%m') AS 'year_month'").
    where(:status => STATUS_POSTED).
    order("1 DESC").
    limit(limit)
  }

end
