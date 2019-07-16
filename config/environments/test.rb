Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
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

  # Configure public file server for tests with Cache-Control for performance.
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    "Cache-Control" => "public, max-age=3600"
  }

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false
  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: Rails.application.secrets.server_name }
  config.action_mailer.asset_host = "http://#{Rails.application.secrets.server_name}"

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

  # Randomize the order test cases are executed.
  config.active_support.test_order = :random

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.cache_store = :null_store

  config.after_initialize do
    Bullet.enable = true
    Bullet.bullet_logger = true
    if ENV["BULLET"]
      Bullet.raise = true # raise an error if n+1 query occurs
    end
  end

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  logger = ActiveSupport::Logger.new("/var/log/rails/tst-www-deciditorino.portali.csi.it_443/#{Rails.env}.log")

  # log level
  config.log_level = :info

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  logger.formatter = config.log_formatter
  config.logger = ActiveSupport::TaggedLogging.new(logger)

  # SPID logout url
  config.spid_logout_url = '/tst_deciditorinosliv1spid_gasp_coto/logout.do'
end