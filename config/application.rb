require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Poker
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # errorメッセージで型くずれを防ぐ...失敗
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      %Q(#{html_tag}).html_safe
    end

    # Flat-UI
    config.assets.paths << "#{Rails}/vendor/assets/fonts"

    # APIの読み込み
    config.paths.add File.join('app', 'apis'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'apis', '*')]

    # Grape+JBuilderを使うための設定
    # config.middleware.use(Rack::Config) do |env|
    #   env['api.tilt.root'] = Rails.root.join 'app', 'views', 'api'
    # end

  end
end

