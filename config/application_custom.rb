module Consul
  class Application < Rails::Application

  	config.i18n.default_locale = :it
    config.i18n.available_locales = [:en, :es, :it, :fr, :nl, 'pt-BR']
    config.i18n.fallbacks = { 'es' => 'it', 'en' => 'it', 'fr' => 'it', 'pt-br' => 'it', 'nl' => 'en' }

  	config.autoload_paths << "#{Rails.root}/lib/custom"

  	# Use default logging formatter so that PID and timestamp are not suppressed.
    config.log_formatter = ::Logger::Formatter.new

    # disable color log
  	config.colorize_logging = false

    # SMTP configuration
    config.action_mailer.default_url_options = { host: Rails.application.secrets.server_name }

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
    	address: Rails.application.secrets.smtp_address,
    	port: Rails.application.secrets.smtp_port
    }

    config.verify_residence_on_login = true
  end
end
