require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Language
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.default_locale = :en
    config.autoload_paths += %W(#{config.root}/app/services)
    config.active_job.queue_adapter = Rails.env.production? ? :sidekiq : :async
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
  end
end
