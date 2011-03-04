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

  validates_presence_of :title, :body
  validates_presence_of :posted_at, :if => lambda { |post| post.status == STATUS_POSTED }
  #validates_existence_of :user
  validates_inclusion_of :status, :in => STATUSES.keys

  before_validation :set_default_attributes, :on => :create
  before_validation :set_posted_at

  scope :recent, order("posts.posted_at DESC").limit(5)
  scope :posted, joins(:comments).where("posts.status = ?", STATUS_POSTED)

  def posted=(val)
    self.status = STATUS_POSTED if !!val
  end

private
  def set_default_attributes
    self.status ||= STATUS_DRAFT
    true
  end

  def set_posted_at
    self.posted_at ||= Time.now if self.status == STATUS_POSTED
  end

end
