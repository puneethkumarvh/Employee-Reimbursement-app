require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ReimbursementPortal
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
     # Enable CSRF protection (this should already be enabled by default)
     config.action_controller.allow_forgery_protection = true

     # Configure OmniAuth full host URL for handling OAuth callbacks
     OmniAuth.config.full_host = Rails.env.production? ? 'https://your-production-url.com' : 'http://localhost:3000'
 
     # Optional: Handle OmniAuth failures gracefully
     OmniAuth.config.on_failure = Proc.new do |env|
       OmniAuth::FailureEndpoint.new(env).redirect_to_failure
     end
  end
end
