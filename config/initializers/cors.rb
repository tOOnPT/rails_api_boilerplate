# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

# HTTP Origin header should be checked against the site's origin as an additional CSRF defense
Rails.application.config.action_controller.forgery_protection_origin_check = false

debug_options = { debug: true, logger: Rails.logger }
Rails.application.config.middleware.insert_before 0, Rack::Cors, debug_options do
  allow do
    origins "*"
      resource "/*", headers: :any, methods: %i[get post put options delete]
  end
end
