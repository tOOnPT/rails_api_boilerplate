require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you"ve limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsAPIBoilerplate
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.autoload_paths << Rails.root.join("lib")

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Tell your app to use the Rack::Attack middleware.
    config.middleware.use Rack::Attack

    # Read your .env VARS here and get them with ENV.fetch ;)
    # config.some_var = ENV.fetch("<env key>", "<default value>")

    # Allow GET, POST or PUT requests from any origin on any resource.
    config.middleware.insert_before 0, Rack::Cors, { debug: true, logger: Rails.logger } do
      allow do
        origins "*"
        resource "/*", headers: :any, methods: %i[get post put]
      end
    end
  end
end
