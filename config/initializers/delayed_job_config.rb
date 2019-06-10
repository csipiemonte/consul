if Rails.env.development? || Rails.env.staging? || Rails.env.preproduction?
  Delayed::Worker.delay_jobs = false
  Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))
elsif Rails.env.test?
  Delayed::Worker.delay_jobs = false
  Delayed::Worker.logger = Logger.new("/var/log/rails/tst-www-deciditorino.portali.csi.it_443/delayed_job.log")
else
  # production
  Delayed::Worker.delay_jobs = false
  Delayed::Worker.logger = Logger.new("/var/log/rails/www.deciditorino.it_443/delayed_job.log")
end
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 2
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 1500.minutes
Delayed::Worker.read_ahead = 10
Delayed::Worker.default_queue_name = "default"
Delayed::Worker.raise_signal_exceptions = :term