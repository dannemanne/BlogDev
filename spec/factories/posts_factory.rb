FactoryGirl.define do
  factory :post do
    user
    sequence(:title) { |n| "Post title #{n}" }
    body 'Here is the post body'
    status Post::STATUS_POSTED

    factory :draft do
      status Post::STATUS_DRAFT
    end
  end
end
