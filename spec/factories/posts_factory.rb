FactoryGirl.define do
  factory :post do
    user
    sequence(:title) { |n| "Post title #{n}" }
    body 'Here is the post body'
  end
end
