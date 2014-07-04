FactoryGirl.define do
  factory :post do
    user
    sequence(:title) { |n| "Post title #{n}" }
    body 'Here is the post body'
    status PostStatus::POSTED
    allow_comments true

    factory :post_with_comments do

      ignore do
        no_of_comments 3
      end

      after(:create) do |post, evaluator|
        FactoryGirl.create_list(:comment, evaluator.no_of_comments, post: post)
      end

    end

    factory :draft do
      status PostStatus::DRAFT
    end
  end
end
