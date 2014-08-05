require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NewRuckus
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    require 'middleware/force_host_name'
    if Rails.env.production?
      config.middleware.insert_before Rack::Lock, ForceHostName, 'newruckus.org'
      config.middleware.use ExceptionNotifier,
        sender_address: %{"notifier" <notifier@newruckus.org>},
        exception_recipients: %w{paul@innig.net},
        ignore_if: lambda { |e| e.message =~ /^Couldn't find Page with ID=/ },
        ignore_crawlers: %w{Googlebot bingbot Baiduspider Wotbox YoudaoBot msnbot WBSearchBot Ezooms Aboundex AhrefsBot MJ12bot NextGenSearchBot heritrix 80legs CCBot Ocelli YandexBot intelium_bot ip-web-crawler},
        ignore_exceptions: []  # for now; we'll see how bad it gets
    end
  end
end
