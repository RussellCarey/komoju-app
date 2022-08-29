require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Server
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0


    config.session_store(:cookie_store, key: '_interslice_session')
    
    # Cookies are read and written through ActionController#cookies. The cookies being read are the ones received along with the request, 
    # the cookies being written will be sent out with the response.
    config.middleware.use(ActionDispatch::Cookies)

    # You can add a new middleware to the middleware stack 
    # config.middleware.use(new_middleware, args) - Adds the new middleware at the bottom of the middleware stack.
    config.middleware.use(config.session_store, config.session_options)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
