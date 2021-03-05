FactoryBot.define do
  factory :linkback do
    sequence(:source_uri) { |n| "http://my.blog.com/post-#{n}" }
    sequence(:target_uri) { |n| "http://dannemanne.com/post-#{n}" }
  end
end
