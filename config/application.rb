require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require_relative '../lib/ext/hash'

module Publimaster
  class Application < Rails::Application

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.autoload_paths << Rails.root.join('lib')
    
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'pt-BR'

    # config.to_prepare do
    #   DeviseTokenAuth::SessionsController.skip_before_filter :authenticate_user!
    # end

    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :expose => %w[ access-token client expiry token-type uid ], :methods => [:get, :post, :delete, :put, :options, :head]
      end
    end
    
  end
end
