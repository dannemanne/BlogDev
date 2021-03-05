FactoryBot.define do
  factory :cheat_sheet do
    sequence(:title) { |n| "Cheat Sheet No. #{n}" }
    body { "=== Cheating is good sometimes\n\nLorem Ipsum etc, etc" }
  end
end
