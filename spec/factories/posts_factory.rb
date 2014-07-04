FactoryGirl.define do
  factory :post do
    user
    sequence(:title) { |n| "Post title #{n}" }
    body 'Here is the post body'
    status PostStatus::POSTED
    allow_comments true

    factory :draft do
      status PostStatus::DRAFT
    end
  end
end
