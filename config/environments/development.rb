Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Because autoloading is disabled in production environments with Rails 5,
  # using autoload_paths will not load needed classes from specified paths.
  # The solution to this, is to ask Rails to eager load classes.
  config.eager_load_paths += ["#{config.root}/lib"]
  config.eager_load_paths += ["#{config.root}/lib/custom"]

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = false

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=172800"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: Rails.application.secrets.server_name }
  config.action_mailer.asset_host = "https://#{Rails.application.secrets.server_name}"

  # Deliver emails to a development mailbox at /letter_opener
  # config.action_mailer.delivery_method = :letter_opener
  # config.action_mailer.perform_caching = false
  # SMTP configuration to deliver emails
  # Uncomment the following block of code and add your SMTP service credentials
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: Rails.application.secrets.smtp_address,
    port: Rails.application.secrets.smtp_port
  #   domain:               'example.com',
  #   user_name:            '<username>',
  #   password:             '<password>',
  #   authentication:       'plain',
  #   enable_starttls_auto: true
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true
  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.cache_store = :dalli_store
  config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"

  config.after_initialize do
    Bullet.enable = true
    Bullet.bullet_logger = true
    if ENV["BULLET"]
      Bullet.rails_logger = true
      Bullet.add_footer = true
    end
  end
  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  logger = ActiveSupport::Logger.new("/var/log/rails/dev-www-deciditorino.portali.csi.it_443/#{Rails.env}.log")

  # log level
  config.log_level = :debug

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  logger.formatter = config.log_formatter
  config.logger = ActiveSupport::TaggedLogging.new(logger)

  # SPID logout url
  config.spid_logout_url = '/dev_deciditorinosliv1spid_gasp_coto/logout.do'
end
