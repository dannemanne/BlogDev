require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require_relative '../lib/pingback_rack'

module Blog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Configure generator behavior
    config.generators do |g|
      g.fixture_replacement :factory_bot, dir: 'spec/factories', suffix: 'factory'
      g.assets false
    end

    config.middleware.use PingbackRack

    config.exceptions_app = self.routes

  end
end
