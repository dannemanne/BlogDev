release: bundle exec rake db:migrate & bundle exec rake webpacker:compile
web: bundle exec unicorn -p $PORT -E $RACK_ENV -c config/unicorn.rb
