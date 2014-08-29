Cloudinary.config do |config|

  if Rails.env.production?

    # On Heroku, we read environment variables to get the configurations
    config.cloud_name = ENV['CLOUDINARY_NAME']
    config.api_key =    ENV['CLOUDINARY_KEY']
    config.api_secret = ENV['CLOUDINARY_SECRET']

  elsif Rails.env.development?

    # In dev and test, we read options from a yml file that is not present
    # in the repository, only locally
    options = YAML.load_file File.join(Rails.root, 'config', 'cloudinary.yml')
    config.cloud_name = options['cloud_name']
    config.api_key =    options['api_key']
    config.api_secret = options['api_secret']

  else # Test


  end

  # Default options
  config.cdn_subdomain = true
end
