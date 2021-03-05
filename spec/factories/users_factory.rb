FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "demo#{n}" }
    sequence(:email) { |n| "demo#{n}@factory.com" }
    role { 0 } # Guest
    password { 'demo_password' }
    password_confirmation { |u| u.password }

    factory :admin do
      role { 9 } # Admin
    end
  end
end
