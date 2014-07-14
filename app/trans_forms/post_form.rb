class PostForm < ApplicationTransForm
  set_main_model :post

  # Define the attributes available for this specific form model. The attributes
  # are declared according to the Virtus standard
  #
  #   attribute :name,      String
  #   attribute :age,       Numeric
  #   attribute :phone_no,  Array
  attribute :title,           String
  attribute :body,            String
  attribute :status,          Integer
  attribute :tag_names,       String
  attribute :allow_comments,  Boolean, default: false


  # Define validations according to the ActiveModel conventions
  #
  #   validates :name,  presence: true
  #   validates :age,   numericality: { greater_than_or_equal_to: 18 }
  validates :current_user,  presence: true
  validates :post,          presence: true

  transaction do
    # Perform all actions inside this block. If anything goes wrong, i.e. an
    # an error is raised because of validation errors, then everything that
    # has already been done inside this block is rolled back.
    #
    #   self.user = User.create!(name: name, age: age, phone_no: phone_no)
    post.attributes = { title: title, body: body, status: status, allow_comments: allow_comments }
    post.user = current_user
    post.save!

    # Parses +tag_names+ an assigns appropriate Tags
    post.tags = tag_names.split(',').map { |tag| Tag.find_or_create_by(name: tag.strip) }
    post.save!
  end

end