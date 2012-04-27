class CheatSheet < ActiveRecord::Base
  validates_presence_of :title, :body
  validates_uniqueness_of :category

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
