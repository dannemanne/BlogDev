class PostStatus < BaseValue
  DRAFT = 0
  POSTED = 1
  ARCHIVED = 2

  set_values({ DRAFT    => { label: :draft },
               POSTED   => { label: :posted },
               ARCHIVED => { label: :archived }
             })

end
