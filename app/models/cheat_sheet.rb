class CheatSheet < ActiveRecord::Base
  validates :title,   presence: true, uniqueness: true
  validates :body,    presence: true

  def category_stub
    category.downcase.gsub(/[^a-z0-9_\-]/i, "-").gsub(/\-+/, "-")
  end

  def title_stub
    "#{category_stub}-#{title.downcase.gsub(/[^a-z0-9_\-]/i, "-").gsub(/\-+/, "-")}"
  end

  def display_body
    Kramdown::Document.new(body).to_html.html_safe
  end

end
