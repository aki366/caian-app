require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CaianApp
  class Application < Rails::Application
    config.i18n.default_locale = :ja
    config.action_dispatch.default_headers.delete 'X-Frame-Options' 
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local
    # config.eager_load_paths << Rails.root.join("extras")

    config.exceptions_app = self.routes

    # CORS Configuration
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins(ENV['CORS_ORIGINS']&.split(',') || [])
        resource '*',
                 headers: :any,
                 methods: %i[get post put patch delete options head],
                 credentials: true
      end
    end
  end
end
