require_relative 'boot'

require 'rails/all'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module AlMizan
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    Dotenv::Railtie.load
    config.time_zone = 'Jakarta'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*','*.{rb,yml}').to_s]
    config.i18n.default_locale = :id
    # config.i18n.available_locales = [:id, :en]
    config.i18n.available_locales = [:en, :id, :sa]
    config.action_controller.permit_all_parameters = true
    def secrets
	  @secrets ||= begin
	    yaml = YAML.load(File.open("#{Rails.root}/config/secrets.yml"))[Rails.env]
	    ActiveSupport::OrderedOptions.new.merge!(yaml.symbolize_keys)
	  end
	end
	# Code for ckeditor to precompile basepath.js.erb
    #config.assets.precompile += Ckeditor.assets
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/services)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

  end
end
