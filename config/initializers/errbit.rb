Airbrake.configure do |config|
  config.host = 'https://oops.marcano.io'
  config.project_id = 1 # required, but any positive integer works
  config.project_key = '63fdee8ae7e529e0d3c910c726ba3147'
  config.performance_stats = false

  # Uncomment for Rails apps
  config.environment = Rails.env
  config.ignore_environments = %w(development test)
end
