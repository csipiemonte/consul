module Consul
  class Application < Rails::Application
  	config.i18n.default_locale = :it
    config.i18n.available_locales = [:en, :es, :it, :fr, :nl, 'pt-BR']
    config.i18n.fallbacks = { 'it' => 'es', 'fr' => 'es', 'pt-br' => 'es', 'nl' => 'en'}

  	config.autoload_paths << "#{Rails.root}/lib/custom"
  	config.colorize_logging = false                   # per disabilitare il colore dai log
  end
end
