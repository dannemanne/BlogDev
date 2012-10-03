
Factory.define :user do |f|
  f.sequence(:name) { |n| "demo#{n}" }
  f.sequence(:email) { |n| "demo#{n}@factory.com" }
  f.role 0 # Guest
  f.password "demo_password"
  f.password_confirmation { |u| u.password }
end

Factory.define :admin, class: User do |f|
  f.sequence(:name) { |n| "demo_admin#{n}" }
  f.sequence(:email) { |n| "demo_admin#{n}@factory.com" }
  f.role 9 # Admin
  f.password "demo_password"
  f.password_confirmation { |u| u.password }
end

Factory.define :post do |f|
  f.sequence(:title) { |n| "Post title #{n}" }
  f.body "Here is the post body"
end
