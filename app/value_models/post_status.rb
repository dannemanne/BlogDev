class PostStatus < BaseValue
  DRAFT = 0
  POSTED = 1
  ARCHIVED = 2

  add_value DRAFT,    :draft
  add_value POSTED,   :posted
  add_value ARCHIVED, :archived

end
