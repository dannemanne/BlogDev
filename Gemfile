source 'http://rubygems.org'
ruby '2.4.5'

gem 'unicorn'
gem 'rails', '4.2.10'
gem 'pg', '~> 0.15'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem "rspec-rails", '3.8.0'
  gem 'capybara', '2.4.4'
  gem 'foreman'
  gem 'pry'
end

group :test do
  gem "codeclimate-test-reporter", require: nil
  gem "factory_girl_rails"
end

gem 'devise', '~> 4.0.0'
gem 'cancancan', '~> 1.8.4'
gem 'jquery-rails', '~> 2.0.1'
gem 'kramdown'
gem 'xmlrpc'
gem 'pingback'
gem 'paperclip', '~> 3.0.4'
gem 'ancestry'
gem 'draper', '~> 1.3.1'
gem 'cloudinary', '~> 1.0.76'
gem 'trans_forms', git: 'https://github.com/dannemanne/trans_forms.git'

gem 'foundation-rails', '~> 5.2.3.0'
