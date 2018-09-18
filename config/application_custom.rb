module Consul
  class Application < Rails::Application

    config.i18n.enforce_available_locales = false
    config.i18n.default_locale = :it
    config.i18n.available_locales = [:it]

    config.autoload_paths << "#{Rails.root}/lib/custom"

    # disable color log
    config.colorize_logging = false

    config.verify_residence_on_login = true
  end
end
